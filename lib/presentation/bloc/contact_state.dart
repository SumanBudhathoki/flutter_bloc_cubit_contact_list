import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_task_1_contact_app/data/models/contact.dart';

enum ContactStatus { inital, loading, loaded, error }

class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object?> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<ContactModel> contacts;

  const ContactLoaded(this.contacts);

  @override
  List<Object?> get props => [contacts];
}

class ContactError extends ContactState {
  final String errorMessage;

  const ContactError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
