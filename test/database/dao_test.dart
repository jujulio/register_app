import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart';
import 'package:register_app/database/dao.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  late MockDatabase database;
  late Dao dao;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    database = MockDatabase();
    dao = Dao();
  });

  tearDownAll(() {
    // Maybe delete the database here
  });

  test('should return an instance of Database', () async {
    registerFallbackValue(join(any(), "register_database.db"));

    when(() => openDatabase(any(), onCreate: (db, version) => any()))
        .thenAnswer((invocation) => Future.value(database));

    final result = await dao.openDatabaseConnection();

    expect(result.isOpen, true);

    // verify(() => openDatabase(any(), onCreate: any())).called(1);
    // verify(() => getDatabasesPath()).called(1);
    // verify(() =>
    //         openDatabase(any(), onCreate: any(named: 'onCreate'), version: 1))
    //     .called(1);
    // verify(() => join(any(), any())).called(1);
  });
}
