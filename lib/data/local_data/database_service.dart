import 'package:flutter_bloc_task_1_contact_app/data/local_data/contact_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? _database;

  // Create database if not available
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  // Get the path for the sqflite database
  Future<String> get fullPath async {
    const name = "contact.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }

  // Initialize the database
  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  // Create a table
  Future<void> create(Database database, int version) async =>
      await ContactDB().createTable(database);
}
