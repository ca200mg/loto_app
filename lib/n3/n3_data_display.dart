import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; // もしくはmoorなどのSQLiteパッケージ

class N3DataDisplay extends StatefulWidget {
  final String n3DataDisplay;
  const N3DataDisplay(this.n3DataDisplay, {Key? key}) : super(key: key);

  @override
  _N3DataDisplay createState() => _N3DataDisplay();
}

class _N3DataDisplay extends State<N3DataDisplay> {
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
    'n3',
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
          ? const Center(child: CircularProgressIndicator()) // データが読み込まれるまでローディング表示
          : ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (BuildContext context, int index) {
          // データをリスト表示する部分
          return ListTile(
            title: Row(
              children: [
                Text('第${_dataList[index]['no']}回'),
                const SizedBox(width: 10.0, ),
                Text(_dataList[index]['date']),
              ],
            ), // 例えば、'date'カラムのデータを表示
            subtitle: Column(
              children: [
                Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('本数字'),
                  const SizedBox(width: 24.0, ),
                  Text(_dataList[index]['main1'].toString()),
                  const SizedBox(width: 10.0, ),
                  Text(_dataList[index]['main2'].toString()),
                  const SizedBox(width: 10.0, ),
                  Text(_dataList[index]['main3'].toString()),
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
