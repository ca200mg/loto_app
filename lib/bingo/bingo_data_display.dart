import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; // もしくはmoorなどのSQLiteパッケージ

class BingoDataDisplay extends StatefulWidget {
  final String bingoDataDisplay;
  const BingoDataDisplay(this.bingoDataDisplay, {Key? key}) : super(key: key);

  @override
  _BingoDataDisplay createState() => _BingoDataDisplay();
}

class _BingoDataDisplay extends State<BingoDataDisplay> {
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
    'bingo',
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
                  // Text(_dataList[index]['main1']),
                  // const SizedBox(width: 10.0, ),
                  // Text(_dataList[index]['main2']),
                  // const SizedBox(width: 10.0, ),
                  // Text(_dataList[index]['main3']),
                  // const SizedBox(width: 10.0, ),
                  // Text(_dataList[index]['main4']),
                  // const SizedBox(width: 10.0, ),
                  // Text(_dataList[index]['main5']),
                  // const SizedBox(width: 10.0, ),
                  // Text(_dataList[index]['main6']),
                  // const SizedBox(width: 10.0, ),
                  // Text(_dataList[index]['main7']),
                  // const SizedBox(width: 10.0, ),
                  // Text(_dataList[index]['main8']),
                  SizedBox(
                    width: 180,
                    child: _returnWinningTable(index, _dataList))
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

Table _returnWinningTable(int index, List<Map<String, dynamic>> winningNumbers,){
  List<String> winningNumber = [];
  for(int i=1; i <= 8; i++){
    winningNumber.add(winningNumbers[index]['main$i']);
  }
  winningNumber.insert(4, 'free');
  // 表示する列数
  int columns = 3;

  // テーブルにデータを追加
    List<TableRow> rows = [];
    for (int i = 0; i < winningNumber.length; i += columns) {
      List<String> rowData = winningNumber.sublist(i, i + columns);
      List<Widget> widgets = rowData.map((item) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item,
            style: const TextStyle(fontSize: 18.0),
          ),
        );
      }).toList();
      rows.add(TableRow(
        children: widgets,
        
      ));
    }
    return Table(
        border: TableBorder.all(),
        children: rows,
      );
}
