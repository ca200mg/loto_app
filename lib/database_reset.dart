import 'package:sqflite/sqflite.dart';

Future<void> deleteAllDataFromAllTable() async {
  List<String> tableNames = ['loto7', 'loto6', 'bingo', 'miniloto', 'n3', 'n4', 'qoo'];
  Database database = await openDatabase('lotodata.db');

  await database.transaction((txn) async {
    for (var tableName in tableNames) {
      await txn.rawDelete('DELETE FROM $tableName');
    }
  });
}

Future<void> deleteAllDataFromAllTableC() async {
  List<String> tableNames = ['loto7', 'loto6', 'bingo', 'miniloto', 'n3', 'n4', 'qoo'];
  Database database = await openDatabase('lotodata_c.db');

  await database.transaction((txn) async {
    for (var tableName in tableNames) {
      await txn.rawDelete('DELETE FROM $tableName');
    }
  });
}