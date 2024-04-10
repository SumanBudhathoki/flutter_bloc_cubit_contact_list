// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_1_contact_app/data/models/contact.dart';
import 'package:flutter_bloc_task_1_contact_app/presentation/cubit/contact_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      body: BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) {
          if (state == ContactState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state == ContactState.loaded) {
            // Contact data has been loaded for display
            return _buildContactList(context);
          } else if (state == ContactState.error) {
            return const Center(child: Text('Error loading contacts!'));
          } else {
            // Initial state, fetch contacts
            _requestContactsPermission(context);
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildContactList(BuildContext context) {
    return FutureBuilder<List<ContactModel>>(
      future: context.read<ContactCubit>().getAllContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final contacts = snapshot.data;
          if (contacts != null && contacts.isNotEmpty) {
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Text(
                        contact.name[0],
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      )),
                  title: Text(contact.name),
                  subtitle: Text(contact.phoneNumber),
                );
              },
            );
          } else {
            return const Center(child: Text('No contacts available'));
          }
        }
      },
    );
  }

  // Handled the permission for contact
  Future<void> _requestContactsPermission(BuildContext context) async {
    final PermissionStatus permissionStatus =
        await Permission.contacts.request();
    if (permissionStatus.isGranted) {
      context.read<ContactCubit>().fetchContactsAndStore();
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Permission Required"),
            content: const Text(
                "This app requires access to contacts to funtion properly"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok")),
            ],
          );
        },
      );
    }
  }
}
