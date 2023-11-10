import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';
import 'data_display.dart';
import 'loto6/loto6_flame.dart';
import 'dustbox/my_home_page.dart';
import 'dustbox/test/test1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: checkIfDataExistsAndCallApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // まだデータベースの処理が完了していない場合、ローディングインジケータを表示
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            // データベースの処理が完了した場合は、Loto6Flameを表示
            return Loto6Flame();
          }
        },
      ),
    );
  }
}

Future<void> checkIfDataExistsAndCallApi() async {
  const allDate = '1994-10-06';//'2023-10-20'; //
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'lotodata.db');
  bool fileExists = await databaseExists(path);

  if (!fileExists) {
    print('display.データベースは存在しない');
    await fetchDataAndInsertToDatabase(allDate);
    await fetchDataAndInsertToDatabaseC(allDate);

  } else {
    print('display.データベースは存在する');
    Database database = await openDatabase(path);
    List<Map<String, dynamic>> table = await database.query(
      'sqlite_master',
      where: 'name = ?',
      whereArgs: ['n3'],
    );

    if (table.isNotEmpty) {
      print('display.テーブルは存在する');
      List<Map<String, dynamic>> latestDateData = await database.rawQuery(
        'SELECT date FROM n3 ORDER BY date DESC LIMIT 1',
      );

      if (latestDateData.isNotEmpty) {
        print('display.テーブルは存在する');
        String latestDate = latestDateData.first['date'];
        print(latestDate);
        await fetchDataAndInsertToDatabase(latestDate);
        await fetchDataAndInsertToDatabaseC(latestDate);

      } else {
        await fetchDataAndInsertToDatabase(allDate);
        await fetchDataAndInsertToDatabaseC(allDate);
      }
    } else {
      print('display.テーブルは存在しない');
      await fetchDataAndInsertToDatabase(allDate);
      await fetchDataAndInsertToDatabaseC(allDate);
    }
  }
}
