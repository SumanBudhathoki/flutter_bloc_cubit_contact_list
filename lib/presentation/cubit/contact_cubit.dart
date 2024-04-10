import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_1_contact_app/data/local_data/contact_db.dart';
import 'package:flutter_bloc_task_1_contact_app/data/local_data/database_service.dart';
import 'package:flutter_bloc_task_1_contact_app/data/models/contact.dart';

enum ContactState { initial, loading, loaded, error }

class ContactCubit extends Cubit<ContactState> {
  final DatabaseService _databaseService;
  ContactCubit(this._databaseService)
      : super(ContactState.initial); //Initial state at the begening

  // Fetch the data
  Future<void> fetchContactsAndStore() async {
    try {
      emit(ContactState.loading);
      final contacts = await ContactsService
          .getContacts(); //get the contact from phone's contact
      await _storeContactsInDatabase(contacts);
      emit(ContactState.loaded); //Change the state as loaded
    } catch (e) {
      emit(ContactState.error);
    }
  }

  // Store the contacts in the table
  Future<void> _storeContactsInDatabase(Iterable<Contact> contacts) async {
    final database = await _databaseService.database;
    final contactDB = ContactDB();
    await contactDB.createTable(database);

    for (final contact in contacts) {
      await contactDB.create(
        id: int.parse(contact.identifier ?? "0"),
        name: contact.displayName ?? "xxx",
        phoneNumber: contact.phones?.isNotEmpty == true
            ? contact.phones!.first.value ?? "-"
            : "-",
      );
    }
  }

  Future<List<ContactModel>> getAllContacts() async {
    try {
      final contactDB = ContactDB();
      final contacts = await contactDB.fetchAll();
      return contacts;
    } catch (e) {
      throw Exception("Failed to get contacts");
    }
  }
}
