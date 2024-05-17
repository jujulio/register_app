// ignore_for_file: avoid_print

import 'package:register_app/database/dao.dart';
import 'package:register_app/model/register.dart';
import 'package:sqflite/sqflite.dart';

import 'package:uuid/uuid.dart';

class RegisterRepository extends Dao {
  final String tableName = "REGISTER";
  final uuid = const Uuid();

  Future<List<Register>> get() async {
    final database = await openDatabaseConnection();
    List<Register> registerList = [];

    try {
      List<Map<String, Object?>> maps = await database.query(tableName);

      List<Register> registerList = List.generate(maps.length, (index) {
        return Register.fromMap({
          'id': maps[index]['id'],
          'name': maps[index]['name'],
          'cpfCnpj': maps[index]['cpfCnpj'],
          'email': maps[index]['email'],
          'phoneNumber': maps[index]['phoneNumber'],
          'address': maps[index]['address'],
          'typeCharacter': maps[index]['typeCharacter'],
          'birthday': maps[index]['birthday'],
        });
      });

      return registerList;
    } catch (error) {
      print("Erro ao buscar os registros Erro: $error");
    }

    return registerList;
  }

  Future<Register?> insert(Register register) async {
    final database = await openDatabaseConnection();
    register = register.copyWith(id: uuid.v4());

    try {
      await database.insert(
        tableName,
        register.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return register;
    } catch (error) {
      print("Erro ao salvar ${register.toString()} Erro: $error");
      return null;
    }
  }

  Future<void> update(Register register) async {
    final database = await openDatabaseConnection();
    try {
      await database.update(tableName, register.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: "id=?",
          whereArgs: [register.id]);
    } catch (error) {
      print("Erro ao atualizar ${register.toString()} Erro: $error");
    }
  }

  Future<Register?> remove(Register register) async {
    final database = await openDatabaseConnection();
    try {
      await database.delete(tableName, where: "id=?", whereArgs: [register.id]);
      return register;
    } catch (error) {
      print("Erro ao remover ${register.toString()} Erro: $error");
      return null;
    }
  }
}
