import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_task_1_contact_app/data/models/contact.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class AddContact extends ContactEvent {
  final ContactModel newContact;

  const AddContact(this.newContact);

  List<Object> get props => [newContact];
}
