// ライブラリのインポート
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loto_app/n3/n3_edit.dart';
import 'package:loto_app/n3/n3_enter.dart';
import 'package:sqflite/sqflite.dart';

// Loto6CheckウィジェットのStatefulWidgetクラス
class N3Check extends StatefulWidget {
  final String n3Check;

  const N3Check(this.n3Check, {Key? key}) : super(key: key);

  @override
  _N3Check createState() => _N3Check();
}

// N3CheckウィジェットのStateクラス
class _N3Check extends State<N3Check> {
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

  // n3データベースAからデータを取得する非同期関数
  Future<void> _getDataFromDatabaseA() async {
    Database database = await openDatabase('lotodata.db');
    List<Map<String, dynamic>> data = await database.query(
      'n3',
      orderBy: 'date DESC',
    );
    setState(() {
      _dataListA = List.from(data);
      // データリストAにデフォルトの値を追加
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99'});
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99'});
      _dataListA.insert(0, {'no': 99, 'bonus': '99', 'date': '9999-99-99', 'main1': '99', 'main2': '99', 'main3': '99'});
    });
  }

  // n4データベースからデータを取得する非同期関数
  Future<void> _getDataFromDatabase() async {
    Database database = await openDatabase('lotodata_c.db');
    List<Map<String, dynamic>> data = await database.query(
      'n3',
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
      'n3',
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
                                  builder: (context) => N3Enter(
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
                                    builder: (context) => N3Edit(
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
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        for (int j = 1; j <= 3; j++)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          i['main$j'].toString(),
                                          style: TextStyle(
                                            color: _checkIfNumberMatchesColor(_checkIfNumberMatches(j, index, i['main$j'],_dataListA))
                                          ),
                                        ),
                                      ),
                                      ],
                                    ),
                                    Text(_returnType(i['type'])),
                                  ],
                                ),
                                
                                    
                                    Text(_countMatchingNumbers(index, 
                                    i['main1'],i['main2'],i['main3'],i['type'],
                                    _dataListA)),
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
                                for (int j = 1; j <= 3; j++)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      _dataListA[index]['main$j'].toString(),
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
  int _checkIfNumberMatches(int forIndex, int index, int selectedNumber, List<Map<String, dynamic>> winningNumber) {
    int count = 0;
    int selected = (selectedNumber) ?? 0;
    int winning = int.tryParse(winningNumber[index]['main$forIndex'].toString()) ?? 0;
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
      default:
        color = Colors.black;
        break;
    }
    return color;
  }
  String _returnType(int type){
    String stringType;
    switch(type){
      case 0:
        stringType = 'ストレート';
      break;
      case 1:
        stringType = 'ボックス';
      break;
      case 2:
        stringType = 'セット';
      break;
      case 3:
        stringType = 'ミニ';
      break;
      default:
        stringType = '';
    }
    return stringType;
  }

  //一致する数字の数をカウントする関数
  String _countMatchingNumbers(int index, 
  // List<Map<String, dynamic>> selectedNumbers, 
  int selectedNumber1,
  int selectedNumber2,
  int selectedNumber3,
  int type,
  List<Map<String, dynamic>> winningNumbers, ) {
    int count = 0;
    Set selectedNumbersSet = {};
    String allcount = '';
    int selected = 0;
    int winning = 0;
    Set winningSet = {};
    
    List<int>selectedNumbers = [selectedNumber1,selectedNumber2,selectedNumber3,];
    print('type:$type');
    if(winningNumbers[index]['date'] != '9999-99-99'){
    switch (type){
      case 0:
        if(selectedNumber1 == winningNumbers[index]['main1'] && 
            selectedNumber2==winningNumbers[index]['main2'] && 
            selectedNumber3==winningNumbers[index]['main3']){
              allcount = 'ストレートあたり';
            }else{
              allcount = 'はずれ';
            }
        break;
      case 1:
        selectedNumbersSet.addAll(selectedNumbers);
        for (int k = 1; k <= 3; k++){
            winningSet.add(int.tryParse(winningNumbers[index]['main$k'].toString()) ?? 0);
        }
        
        if(selectedNumbersSet.containsAll(winningSet) && winningSet.containsAll(selectedNumbersSet)){
          allcount = 'ボックスあたり';
        }else{
          allcount = 'はずれ';
        }
        break;
      case 2:
        selectedNumbersSet.addAll(selectedNumbers);
        for (int k = 1; k <= 3; k++){
            winningSet.add(int.tryParse(winningNumbers[index]['main$k'].toString()) ?? 0);
        }
        if(selectedNumber1 == winningNumbers[index]['main1'] && 
            selectedNumber2==winningNumbers[index]['main2'] && 
            selectedNumber3==winningNumbers[index]['main3']){
              allcount = 'セット:ストレートあたり';
        }else if(selectedNumbersSet.containsAll(winningSet) && winningSet.containsAll(selectedNumbersSet)){
              allcount = 'セット:ボックスあたり';
        }else{
              allcount = 'はずれ';
        }
      case 3:
        if(selectedNumber2==winningNumbers[index]['main2'] && 
            selectedNumber3==winningNumbers[index]['main3']){
              allcount = 'ミニあたり';
        }else{
              allcount = 'はずれ';
        }
      default:
        allcount = '';
        break;
    }
    }else{
      allcount = '';
    }
    
    return allcount;
  }
  
}
