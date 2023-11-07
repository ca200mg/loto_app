import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; // もしくはmoorなどのSQLiteパッケージ

class Loto7DataDisplay extends StatefulWidget {
  final String loto7DataDisplay;
  const Loto7DataDisplay(this.loto7DataDisplay, {Key? key}) : super(key: key);

  @override
  _Loto7DataDisplay createState() => _Loto7DataDisplay();
}

class _Loto7DataDisplay extends State<Loto7DataDisplay> {
  List<Map<String, dynamic>> _dataList = []; // データを保持するリスト
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    // await checkIfDataExistsAndCallApi();
    await _getDataFromDatabase();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getDataFromDatabase() async {
  // データベースにアクセスしてデータを取得する処理
  Database database = await openDatabase('lotodata.db');
  List<Map<String, dynamic>> data = await database.query(
    'loto7',
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
                  SizedBox(width: 10.0, ),
                  Text(_dataList[index]['main7']),
                ],
                ),
                Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ボーナス'),
                  SizedBox(width: 10.0, ),
                  Text(_dataList[index]['bonus1']),
                  SizedBox(width: 10.0, ),
                  Text(_dataList[index]['bonus2']),
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
