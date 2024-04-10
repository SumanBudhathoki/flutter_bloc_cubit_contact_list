import 'package:flutter_bloc_task_1_contact_app/data/local_data/database_service.dart';
import 'package:flutter_bloc_task_1_contact_app/data/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDB {
  final tableName = "contacts";
  // Create table in the database
  Future<void> createTable(Database database) async {
    await database.execute(
        """CREATE TABLE IF NOT EXISTS $tableName(id INTEGER NOT NULL, name TEXT, phoneNumber TEXT)""");
  }

  // Insert data in the table
  Future<int> create(
      {required int id,
      required String name,
      required String phoneNumber,
      avatar}) async {
    final database = await DatabaseService().database;

    final existingContact =
        await _checkExistingContact(name, phoneNumber, database);
    if (existingContact == null) {
      return await database.rawInsert(
          """INSERT INTO $tableName (id, name, phoneNumber) VALUES (?,?,?)""",
          [id, name, phoneNumber]);
    } else {
      return 0;
    }
  }

  // For the contact not to get added when the app is opened again
  Future<ContactModel?> _checkExistingContact(
      String name, String phoneNumber, Database database) async {
    final results = await database.rawQuery(
        """SELECT * from $tableName WHERE name = ? AND phoneNumber = ?""",
        [name, phoneNumber]);
    return results.isNotEmpty ? ContactModel.fromMap(results.first) : null;
  }

  // Get all the data from the table
  Future<List<ContactModel>> fetchAll() async {
    final database = await DatabaseService().database;
    final contacts = await database.rawQuery("""SELECT * from $tableName """);
    return contacts.map((contact) => ContactModel.fromMap(contact)).toList();
  }
}
