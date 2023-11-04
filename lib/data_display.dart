import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loto_app/database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart'; // もしくはmoorなどのSQLiteパッケージ

class DataDisplayPage extends StatefulWidget {
  const DataDisplayPage({Key? key}) : super(key: key);

  @override
  _DataDisplayPageState createState() => _DataDisplayPageState();
}

class _DataDisplayPageState extends State<DataDisplayPage> {
  List<Map<String, dynamic>> _dataList = []; // データを保持するリスト

  @override
  void initState() {
   super.initState();

    // まずはデータを取得してデータベースに挿入
    checkIfDataExistsAndCallApi().then((_) {
    // データ挿入後にデータベースからデータを取得する
    _getDataFromDatabase();
  });
  }
  
  //データベースの存在確認、テーブルの存在確認、
  Future<void> checkIfDataExistsAndCallApi() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'lotodata.db');
  bool fileExists = await databaseExists(path);

  if (!fileExists) {
    // データベースが存在しない場合は、特定の日付でデータを取得
    fetchDataAndInsertToDatabase('1994-10-06');
  } else {
    Database database = await openDatabase(path);
    List<Map<String, dynamic>> table = await database.query(
      'sqlite_master',
      where: 'name = ?',
      whereArgs: ['n3'],
    );

    if (table.isNotEmpty) {
      // n3テーブルが存在する場合
      List<Map<String, dynamic>> latestDateData = await database.rawQuery(
        'SELECT date FROM n3 ORDER BY date DESC LIMIT 1'
      );

      if (latestDateData.isNotEmpty) {
        // データが存在する場合は、最新の日付を取得してAPIを呼び出す
        String latestDate = latestDateData.first['date'];
        fetchDataAndInsertToDatabase(latestDate);
      } else {
        // データが存在しない場合の処理
        fetchDataAndInsertToDatabase('1994-10-06');
      }
    } else {
      // n3テーブルが存在しない場合
      fetchDataAndInsertToDatabase('1994-10-06');
    }
  }
}

  Future<void> _getDataFromDatabase() async {
  // データベースにアクセスしてデータを取得する処理
  Database database = await openDatabase('lotodata.db');
  List<Map<String, dynamic>> data = await database.query(
    'loto6',
    orderBy: 'date DESC', // date列を基準に降順でデータを取得する
  );

  setState(() {
    _dataList = data; // 取得したデータをリストに代入
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Data Display'),
      ),
      body: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (BuildContext context, int index) {
          // データをリスト表示する部分
          return ListTile(
            title: Text(_dataList[index]['date']), // 例えば、'date'カラムのデータを表示
            subtitle: Column(
              children: [
                Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('本数字'),
                  SizedBox(width: 24.0, ),
                  Text(_dataList[index]['main1']),
                  SizedBox(width: 10.0, ),
                  Text(_dataList[index]['main2']),
                ],
                ),
                Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ボーナス'),
                  SizedBox(width: 10.0, ),
                  Text(_dataList[index]['bonus']),
                ],
                ),
              ],
            ),// 'main1'カラムのデータを表示
          );
        },
      ),
    );
  }
}
