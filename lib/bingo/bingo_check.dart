// ライブラリのインポート
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loto_app/bingo/bingo_edit.dart';
import 'package:loto_app/bingo/bingo_enter.dart';
import 'package:sqflite/sqflite.dart';

// Loto6CheckウィジェットのStatefulWidgetクラス
class BingoCheck extends StatefulWidget {
  final String bingoCheck;

  const BingoCheck(this.bingoCheck, {Key? key}) : super(key: key);

  @override
  _BingoCheck createState() => _BingoCheck();
}

// BingoCheckウィジェットのStateクラス
class _BingoCheck extends State<BingoCheck> {
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

  // bingoデータベースAからデータを取得する非同期関数
  Future<void> _getDataFromDatabaseA() async {
    Database database = await openDatabase('lotodata.db');
    List<Map<String, dynamic>> data = await database.query(
      'bingo',
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

  // bingoデータベースからデータを取得する非同期関数
  Future<void> _getDataFromDatabase() async {
    Database database = await openDatabase('lotodata_c.db');
    List<Map<String, dynamic>> data = await database.query(
      'bingo',
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
      'bingo',
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
                                  builder: (context) => BingoEnter(
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
                                    builder: (context) => BingoEdit(
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
                            SizedBox(
                              width: 180,
                              child: _returnUserTable(index, 
                                      i['main1'],i['main2'],i['main3'],i['main4'],i['main5'],i['main6'],i['main7'],i['main8'],
                                      _dataListA),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_countMatchingNumbers(index, i['main1'],i['main2'],i['main3'],i['main4'],i['main5'],i['main6'],i['main7'],i['main8'], _dataListA)),
                            ),
                          ],
                        ),
                        const SizedBox(
                              height: 10,
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
                                SizedBox(
                                  width: 180,
                                  child:
                                  _returnWinningTable(index,_dataListA))
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
}
  // 数字の種類を確認する関数
  int _checkIfNumberMatches(int index, String selectedNumber, List<Map<String, dynamic>> winningNumber) {
    int count = 0;
    int selected = int.tryParse(selectedNumber) ?? 0;
    for (int k = 1; k <= 8; k++){
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
    print("Debug: Number from _itemCheckWinning: $num"); // 追加
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
  String selectedNumber5,
  String selectedNumber6,
  String selectedNumber7,
  String selectedNumber8,
  List<Map<String, dynamic>> winningNumbers, ) {
    int count = 0;
    String allcount = '';
    
    // List<String>selectedNumbers = [selectedNumber1,selectedNumber2,selectedNumber3,selectedNumber4,selectedNumber5,selectedNumber6,selectedNumber7,selectedNumber8];

    bool cell_1 = int.tryParse(selectedNumber1) == int.tryParse(winningNumbers[index]['main1']);
    bool cell_2 = int.tryParse(selectedNumber2) == int.tryParse(winningNumbers[index]['main2']);
    bool cell_3 = int.tryParse(selectedNumber3) == int.tryParse(winningNumbers[index]['main3']);
    bool cell_4 = int.tryParse(selectedNumber4) == int.tryParse(winningNumbers[index]['main4']);
    bool cell_5 = int.tryParse(selectedNumber5) == int.tryParse(winningNumbers[index]['main5']);
    bool cell_6 = int.tryParse(selectedNumber6) == int.tryParse(winningNumbers[index]['main6']);
    bool cell_7 = int.tryParse(selectedNumber7) == int.tryParse(winningNumbers[index]['main7']);
    bool cell_8 = int.tryParse(selectedNumber8) == int.tryParse(winningNumbers[index]['main8']);
    
    if(cell_1 && cell_2 && cell_3){
      count ++;
    }
    if(cell_4 && cell_5){
      count ++;
    }
    if(cell_6 && cell_7 && cell_8){
      count ++;
    }
    if(cell_1 && cell_4 && cell_6){
      count ++;
    }
    if(cell_2 && cell_7){
      count ++;
    }
    if(cell_3 && cell_5 && cell_8){
      count ++;
    }
    if(cell_1 && cell_8){
      count ++;
    }
    if(cell_3 && cell_6){
      count ++;
    }
 
    switch (count){
      case 0:
        allcount = '';
        break;
      case 1:
        allcount = '7等';
        break;
      case 2:
        allcount = '6等';
        break;
      case 3:
        allcount = '5等';
        break;
      case 4:
        allcount = '4等';
        break;
      case 5:
        allcount = '3等';
        break;
      case 6:
        allcount = '2等';
        break;
      case 7:
        allcount = '';
        break;
      case 8:
        allcount = '1等';
        break;
      default:
        allcount = '';
        break;
    }
    
    return allcount;
  }
  
int _itemCheckWinning(int index, String number, List<Map<String, dynamic>> winningNumbers){
  int count = 0;
  for(int i = 1; i <= 8; i++){
    String winning = winningNumbers[index]['main$i'];
    if(number == winning){
          count = 1;
    }
  }
  return count;
}

Table _returnUserTable(int index, 
  // List<Map<String, dynamic>> selectedNumbers, 
  String selectedNumber1,
  String selectedNumber2,
  String selectedNumber3,
  String selectedNumber4,
  String selectedNumber5,
  String selectedNumber6,
  String selectedNumber7,
  String selectedNumber8,
  List<Map<String, dynamic>> winningNumbers,){
  
  List<String>selectedNumbers = [selectedNumber1,selectedNumber2,selectedNumber3,selectedNumber4,selectedNumber5,selectedNumber6,selectedNumber7,selectedNumber8];
  // 表示する列数
  int columns = 3;
  selectedNumbers.insert(4, 'free');
  selectedNumbers = selectedNumbers.map((i) => i.padLeft(2, '0')).toList();
  // テーブルにデータを追加
    List<TableRow> rows = [];
    for (int i = 0; i < selectedNumbers.length; i += columns) {
      List<String> rowData = selectedNumbers.sublist(i, i + columns);
      List<Widget> widgets = rowData.map((item) {
        print('item:$item');
        Color color = _checkIfNumberMatchesColor(_itemCheckWinning(index, item, winningNumbers));
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item,
            style: TextStyle(
              fontSize: 18.0,
              color: color,
            ),
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