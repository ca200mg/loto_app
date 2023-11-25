// ライブラリのインポート
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loto_app/qoo/qoo_edit.dart';
import 'package:loto_app/qoo/qoo_enter.dart';
import 'package:sqflite/sqflite.dart';

// QooCheckウィジェットのStatefulWidgetクラス
class QooCheck extends StatefulWidget {
  final String qooCheck;

  const QooCheck(this.qooCheck, {Key? key}) : super(key: key);

  @override
  _QooCheck createState() => _QooCheck();
}

// QooCheckウィジェットのStateクラス
class _QooCheck extends State<QooCheck> {
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

  // qooデータベースAからデータを取得する非同期関数
  Future<void> _getDataFromDatabaseA() async {
    Database database = await openDatabase('lotodata.db');
    List<Map<String, dynamic>> data = await database.query(
      'qoo',
      orderBy: 'date DESC',
    );
    setState(() {
      _dataListA = List.from(data);
      // データリストAにデフォルトの値を追加
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99', 'main4': '99'});
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99', 'main4': '99'});
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99', 'main4': '99'});
    });
  }

  // qooデータベースからデータを取得する非同期関数
  Future<void> _getDataFromDatabase() async {
    Database database = await openDatabase('lotodata_c.db');
    List<Map<String, dynamic>> data = await database.query(
      'qoo',
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
      'qoo',
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
                                  builder: (context) => QooEnter(
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
                                    builder: (context) => QooEdit(
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
                                for (int j = 1; j <= 4; j++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      i['main$j'].padLeft(2, '0') as String,
                                      style: TextStyle(
                                        color: _checkIfNumberMatchesColor(_checkIfNumberMatches(j, index, i['main$j'],_dataListA))
                                            //     index,
                                            //     i['main$j'], 
                                            //       _dataListA)
                                            // ? Colors.green
                                            // : Colors.black,
                                      ),
                                    ),
                                  ),
                                  
                                    Text(_countMatchingNumbers(index, 
                                    // _userDataList.where((element) => element['no'] == _dataList[index]['no']).toList(),
                                    i['main1'],i['main2'],i['main3'],i['main4'],
                                    _dataListA)),
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
                                for (int j = 1; j <= 4; j++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      _dataListA[index]['main$j'],
                                    ),
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
  int _checkIfNumberMatches(int forIndex, int index, String selectedNumber, List<Map<String, dynamic>> winningNumber) {
    int count = 0;
    String selected = selectedNumber;
      String winning = winningNumber[index]['main$forIndex'];
      if(selected == winning){
        count = 1;
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
  String _countMatchingNumbers(int index, 
  // List<Map<String, dynamic>> selectedNumbers, 
  String selectedNumber1,
  String selectedNumber2,
  String selectedNumber3,
  String selectedNumber4,
  List<Map<String, dynamic>> winningNumbers, ) {
    int count = 0;
    String allcount = '';

    if(selectedNumber1 == winningNumbers[index]['main1']){
      count ++;
    }
    if(selectedNumber2 == winningNumbers[index]['main2']){
      count ++;
    }
    if(selectedNumber3 == winningNumbers[index]['main3']){
      count ++;
    }
    if(selectedNumber4 == winningNumbers[index]['main4']){
      count ++;
    }
 
    switch (count){
      case 0:
        allcount = '';
        break;
      case 1:
        allcount = '';
        break;
      case 2:
        allcount = '3等';
        break;
      case 3:
        allcount = '2等';
        break;
      case 4:
        allcount = '1等';
        break;
      default:
        allcount = '';
        break;
    }
    
    return allcount;
  }
  
}
