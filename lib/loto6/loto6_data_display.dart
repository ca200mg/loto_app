import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loto_app/database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart'; // もしくはmoorなどのSQLiteパッケージ

class Loto6DataDisplay extends StatefulWidget {
  final String loto6DataDisplay;
  const Loto6DataDisplay(this.loto6DataDisplay, {Key? key}) : super(key: key);

  @override
  _Loto6DataDisplay createState() => _Loto6DataDisplay();
}

class _Loto6DataDisplay extends State<Loto6DataDisplay> {
  List<Map<String, dynamic>> _dataList = []; // データを保持するリスト
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    await checkIfDataExistsAndCallApi();
    await _getDataFromDatabase();
    setState(() {
      _isLoading = false;
    });
  }
  
  //データベースの存在確認、テーブルの存在確認、
  Future<void> checkIfDataExistsAndCallApi() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'lotodata.db');
  bool fileExists = await databaseExists(path);

  if (!fileExists) {
    print('display.データベースは存在しない');
    // データベースが存在しない場合は、特定の日付でデータを取得
    await fetchDataAndInsertToDatabase('2023-10-20');
  } else {
    print('display.データベースは存在する');
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
        print('display.テーブルは存在する');
        // データが存在する場合は、最新の日付を取得してAPIを呼び出す
        String latestDate = latestDateData.first['date'];
        await fetchDataAndInsertToDatabase(latestDate);
      } else {
        // データが存在しない場合の処理
        await fetchDataAndInsertToDatabase('2023-10-20');
      }
    } else {
      print('display.テーブルは存在しない');
      // n3テーブルが存在しない場合
      await fetchDataAndInsertToDatabase('2023-10-20');
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
      
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // データが読み込まれるまでローディング表示
          : ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (BuildContext context, int index) {
          // データをリスト表示する部分
          return ListTile(
            title: Row(
              children: [
                Text('第' + _dataList[index]['no'].toString() + '回'),
                SizedBox(width: 10.0, ),
                Text(_dataList[index]['date']),
              ],
            ), // 例えば、'date'カラムのデータを表示
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
                  SizedBox(width: 10.0, ),
                  Text(_dataList[index]['main3']),
                  SizedBox(width: 10.0, ),
                  Text(_dataList[index]['main4']),
                  SizedBox(width: 10.0, ),
                  Text(_dataList[index]['main5']),
                  SizedBox(width: 10.0, ),
                  Text(_dataList[index]['main6']),
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
