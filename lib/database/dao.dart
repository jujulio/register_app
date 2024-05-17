import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dao {
  String get _register => '''
    CREATE TABLE REGISTER (
      id TEXT PRIMARY KEY NOT NULL,
      name TEXT NOT NULL,
      cpfCnpj TEXT NOT NULL,
      email TEXT NOT NULL,
      phoneNumber TEXT NOT NULL,
      address TEXT NOT NULL,
      typeCharacter TEXT NOT NULL,
      birthday NUMERIC
    );
  ''';

  Future<Database> openDatabaseConnection() async {
    WidgetsFlutterBinding.ensureInitialized();
    Database database = await openDatabase(
        join(await getDatabasesPath(), 'register_database.db'),
        onCreate: (db, version) {
      return db.execute(_register);
    }, version: 1);

    return database;
  }
}
