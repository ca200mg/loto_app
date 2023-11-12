import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loto_app/loto6/loto6_enter.dart';
import 'package:loto_app/models/lotos.dart';
import 'package:sqflite/sqflite.dart';

class Loto6Check extends StatefulWidget {
  final String loto6Check;

  const Loto6Check(this.loto6Check, {Key? key}) : super(key: key);

  @override
  _Loto6Check createState() => _Loto6Check();
}

class _Loto6Check extends State<Loto6Check> {
  List<Map<String, dynamic>> _dataList = [];
  List<Map<String, dynamic>> _userDataList = [];
  List<Map<String, dynamic>> _dataListA = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    await _getDataFromDatabase();
    await _getDataFromUserDatabase();
    await _getDataFromDatabaseA();
    print(_dataListA);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getDataFromDatabaseA() async {
    Database database = await openDatabase('lotodata.db');
    List<Map<String, dynamic>> data = await database.query(
      'loto6',
      orderBy: 'date DESC',
    );
    setState(() {
      _dataListA = List.from(data);
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99', 'main4': '99', 'main5': '99', 'main6': '99'});
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99', 'main4': '99', 'main5': '99', 'main6': '99'});
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99', 'main4': '99', 'main5': '99', 'main6': '99'});

    });
  }

  Future<void> _getDataFromDatabase() async {
    Database database = await openDatabase('lotodata_c.db');
    List<Map<String, dynamic>> data = await database.query(
      'loto6',
      orderBy: 'date DESC',
    );
    setState(() {
      _dataList = data;
    });
  }

  Future<void> _getDataFromUserDatabase() async {
    Database database = await openDatabase('user_database.db');
    List<Map<String, dynamic>> data = await database.query(
      'loto6',
      orderBy: 'date DESC',
    );
    setState(() {
      _userDataList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Row(
                    children: [
                      Text('第' + _dataList[index]['no'].toString() + '回'),
                      SizedBox(width: 10.0),
                      Text(_dataList[index]['date']),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              int selectedNo = _dataList[index]['no'];
                              String selectedDate =
                                  _dataList[index]['date'];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Loto6Enter(
                                    no: selectedNo,
                                    date: selectedDate,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      for (final i in _userDataList
                          .where((element) => element['no'] ==
                              _dataList[index]['no']))
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('選択数字'),
                            SizedBox(width: 24.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int j = 1; j <= 6; j++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      i['main$j'].padLeft(2, '0') as String,
                                      style: TextStyle(
                                        color: _checkIfNumberMatches(
                                                i['main$j'],
                                                _dataListA[index]['main$j'],
                                                index)
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('本数字'),
                          SizedBox(width: 40.0),
                          if (!(index == 0 || index == 1 || index == 2))
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int j = 1; j <= 6; j++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      _dataListA[index]['main$j'].toString().padLeft(2, '0'),
                                    ),
                                  ),
                                Text(
                                  _dataListA[index]['bonus'].toString().padLeft(2, '0'),
                                ),
                              ],
                            )
                          else
                            Text('未抽選'),
                        ],
                      ),

                    ],
                  ),
                );
              },
            ),
    );
  }

  bool _checkIfNumberMatches(String selectedNumber, String winningNumber, int index) {
  // 選択された数字と当選数字を整数に変換してから比較
  int selected = int.tryParse(selectedNumber) ?? -1;
  int winning = int.tryParse(winningNumber) ?? -1;

  if (_dataListA.length > index) {
    return selected == winning;
  }

  return false;
}


}
