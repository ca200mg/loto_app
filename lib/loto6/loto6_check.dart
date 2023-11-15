// ライブラリのインポート
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loto_app/loto6/loto6_edit.dart';
import 'package:loto_app/loto6/loto6_enter.dart';
import 'package:sqflite/sqflite.dart';

// Loto6CheckウィジェットのStatefulWidgetクラス
class Loto6Check extends StatefulWidget {
  final String loto6Check;

  const Loto6Check(this.loto6Check, {Key? key}) : super(key: key);

  @override
  _Loto6Check createState() => _Loto6Check();
}

// Loto6CheckウィジェットのStateクラス
class _Loto6Check extends State<Loto6Check> {
  // 変数の初期化
  List<Map<String, dynamic>> _dataList = [];
  List<Map<String, dynamic>> _userDataList = [];
  List<Map<String, dynamic>> _dataListA = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData(); // データの取得
  }

  // データを取得する非同期関数
  Future<void> _getData() async {
    if (mounted) {
      await _getDataFromDatabase();
      await _getDataFromUserDatabase();
      await _getDataFromDatabaseA();
      print(_userDataList);
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // loto6データベースAからデータを取得する非同期関数
  Future<void> _getDataFromDatabaseA() async {
    Database database = await openDatabase('lotodata.db');
    List<Map<String, dynamic>> data = await database.query(
      'loto6',
      orderBy: 'date DESC',
    );
    setState(() {
      _dataListA = List.from(data);
      // データリストAにデフォルトの値を追加
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99', 'main4': '99', 'main5': '99', 'main6': '99'});
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99', 'main4': '99', 'main5': '99', 'main6': '99'});
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99', 'main4': '99', 'main5': '99', 'main6': '99'});
    });
  }

  // loto6データベースからデータを取得する非同期関数
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

  // ユーザーデータベースからデータを取得する非同期関数
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
          ? const Center(child: CircularProgressIndicator()) // ローディング中に表示するウィジェット
          : ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (BuildContext context, int index) {
                // 一致した数字の個数を数える
                // String matchingNumbersCount = _countMatchingNumbers(_userDataList
                //     .where((element) => element['no'] == _dataList[index]['no'],)
                //     .toList(), index);

                return ListTile(
                  title: Row(
                    children: [
                      Text('第${_dataList[index]['no']}回'),
                      const SizedBox(width: 10.0),
                      Text(_dataList[index]['date']),
                      const SizedBox(width: 20,),
                      // 一致した数字が3つ以上の場合に'当選'を表示
                      // if (matchingNumbersCount >= 3) const Text('当選'),
                      // Text(matchingNumbersCount),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              int selectedNo = _dataList[index]['no'];
                              String selectedDate = _dataList[index]['date'];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Loto6Enter(
                                    no: selectedNo,
                                    date: selectedDate,
                                  ),
                                ),
                              ).then((result) {
                                if (result != null && result) {
                                  // 更新が成功した場合の処理
                                  // ここで元のページを更新する
                                  _getData();
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      for (final i in _userDataList
                          .where((element) => element['no'] == _dataList[index]['no']))
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('選択数字'),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              iconSize: 12,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                int selectedId = i['id'];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Loto6Edit(
                                      id: selectedId,
                                    ),
                                  ),
                                ).then((result) {
                                  if (result != null && result) {
                                    // 更新が成功した場合の処理
                                    // ここで元のページを更新する
                                    _getData();
                                  }
                                });
                              },
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int j = 1; j <= 6; j++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      i['main$j'].padLeft(2, '0') as String,
                                      style: TextStyle(
                                        color: _checkIfNumberMatchesColor(_checkIfNumberMatches(index, i['main$j'],_dataListA))
                                            //     index,
                                            //     i['main$j'], 
                                            //       _dataListA)
                                            // ? Colors.green
                                            // : Colors.black,
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 8.0),
                                  //   child: Text(
                                  //     i['bonus'].padLeft(2, '0') as String,
                                  //     style: TextStyle(
                                  //       color: _checkIfBonusNumberMatches(
                                  //               i['bonus'], 
                                  //                 _dataListA[index]['bonus'])
                                  //           ? Colors.blue
                                  //           : Colors.black,
                                  //     ),
                                  //   ),
                                  // ),
                              ],
                            ),
                          ],
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('本数字'),
                          const SizedBox(width: 40.0),
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
                                  style:TextStyle(color: Colors.blue)
                                ),
                              ],
                            )
                          else
                            const Text('未抽選'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // 数字の種類を確認する関数
  int _checkIfNumberMatches(int index, String selectedNumber, List<Map<String, dynamic>> winningNumber) {
    int count = 0;
    int selected = int.tryParse(selectedNumber) ?? 0;
    for (int k = 1; k <= 6; k++){
      int winning = int.tryParse(winningNumber[index]['main$k']) ?? 0;
      if(selected == winning){
        count = 1;
      }
    }
    int bonus = int.tryParse(winningNumber[index]['bonus']) ?? 0;
    if(selected == bonus){
      count = 2;
    }
    return count;
  }
  Color _checkIfNumberMatchesColor(int number){
    int num = number;
    Color color;
    switch(num){
      case 0:
        color = Colors.black;
        break;
      case 1:
        color = Colors.green;
        break;
      case 2:
        color = Colors.blue;
        break;
      default:
        color = Colors.black;
        break;
    }
    return color;
  }
  // bool _checkIfBonusNumberMatches(String selectedNumber, String winningNumber) {
  //   int selected = int.tryParse(selectedNumber) ?? 0;
  //   int winning = int.tryParse(winningNumber) ?? 0;
  //   return selected == winning;
  // }

  //一致する数字の数をカウントする関数
  String _countMatchingNumbers(List<Map<String, dynamic>> userData, int index) {
    int count = 0;
    String allcount = '';
    for (final i in userData) {
      for (int j = 1; j <= 6; j++) {
        count += _checkIfNumberMatches(index,i['main$j'], _dataListA);
                 
        
        // if (count >= 3){
        //   allcount = 3;
        // }
        switch (count){
          case 0:
            allcount = '';
            break;
          case 1:
            allcount = '';
            break;
          case 2:
            allcount = '';
            break;
          case 3:
            allcount = '5';
            break;
          case 4:
            allcount = '4';
            break;
          case 5:
            allcount = '3';
            break;
          case 6:
            allcount = '1';
            break;
          default:
            allcount = '2';
            break;
        }
      }
      count = 0;
    }
    return allcount;
  }
}
