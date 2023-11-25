import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BingoEdit extends StatefulWidget {
  int id;
  BingoEdit({required this.id, Key? key}) : super(key: key);

  @override
  State<BingoEdit> createState() => _BingoEditState();
}

class _BingoEditState extends State<BingoEdit> {
  List<String> bingoNums = ['0','0','0','0','0','0','0'];
  List<int> numberList = [0,0,0,0,0,0,0,0];
  double height = 60;
  double width = 300;

  @override
  void initState() {
    super.initState();
    _loadBingoNums();
  }

  Future<void> _loadBingoNums() async {
    List<String> nums = await getBingoNums(widget.id);
    print('nums:$nums');
    setState(() {
      bingoNums = nums;
      print('bingoNums:$bingoNums');
      numberList.clear();
      numberList.addAll(nums.sublist(2, 10).map((num) => int.parse(num)));

    });
  }

@override
Widget build(BuildContext context) {
  // int num = numberList[0];
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text('番号入力'),
    ),
    body: Column(
      children: [
        Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('第${bingoNums[0]}回   ${bingoNums[1]}'),
                ),
        Column(
          children: [
            // 1
              SizedBox(
                      height: height,
                      width: width,
                      child:
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5, // 6つのボタンを1行に表示
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index1) {
                        int number1 = index1 + 1;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              numberList[0] = number1;
                            });
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: numberList[0] == number1 ? Colors.green : Colors.black12,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              number1.toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      },
                    ),
                    ),
                  
      
                
              // 2
             
                  
                  
                  SizedBox(
                    height: height,
                    width: width,
                    child:
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // 6つのボタンを1行に表示
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index2) {
                      int number2 = index2 + 6;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            numberList[1] = number2;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: numberList[1] == number2 ? Colors.green : Colors.black12,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            number2.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    },
                  ),
                  ),
                  
      
                
              // 3
              
                  
                  
                  SizedBox(
                    height: height,
                    width: width,
                    child:
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // 6つのボタンを1行に表示
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index3) {
                      int number3 = index3 + 11;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            numberList[2] = number3;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: numberList[2] == number3 ? Colors.green : Colors.black12,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            number3.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    },
                  ),
                  ),
                  
      
                
              // 4
              
                  
                  
                  SizedBox(
                    height: height,
                    width: width,
                    child:
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // 6つのボタンを1行に表示
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index4) {
                      int number4 = index4 + 16;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            numberList[3] = number4;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: numberList[3] == number4 ? Colors.green : Colors.black12,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            number4.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    },
                  ),
                  ),
                  
      
                
              SizedBox(
                    height: height,
                    width: width,
                    child:
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // 6つのボタンを1行に表示
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index5) {
                      int number5 = index5 + 21;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            numberList[4] = number5;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: numberList[4] == number5 ? Colors.green : Colors.black12,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            number5.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                    height: height,
                    width: width,
                    child:
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // 6つのボタンを1行に表示
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index6) {
                      int number6 = index6 + 26;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            numberList[5] = number6;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: numberList[5] == number6 ? Colors.green : Colors.black12,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            number6.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                    height: height,
                    width: width,
                    child:
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // 6つのボタンを1行に表示
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index7) {
                      int number7 = index7 + 31;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            numberList[6] = number7;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: numberList[6] == number7 ? Colors.green : Colors.black12,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            number7.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                    height: height,
                    width: width,
                    child:
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // 6つのボタンを1行に表示
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index8) {
                      int number8 = index8 + 36;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            numberList[7] = number8;
                          });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: numberList[7] == number8 ? Colors.green : Colors.black12,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            number8.toString(),
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (numberList.length == 8) ? () async {
                      // 選択した数字をMinilotoCheckに渡すなどの処理を行う
                      List<int> preNumSetList1 = numberList;
                      List<String> preNumSetList2 = preNumSetList1.map((num) => num.toString()).toList();
                      await updateBingoData(widget.id, int.parse(bingoNums[0]), bingoNums[1], preNumSetList2);
                      Navigator.pop(context, true);
                      print('pressed');
                    } : null, // numberListの要素数が6でない場合、ボタンを無効にする
                    child: const Text('登録'),
                  ),
                                ElevatedButton(
                    onPressed: (numberList.length == 8) ? () async {
                      // 選択した数字をMinilotoCheckに渡すなどの処理を行う
                      await deleteBingoRecord(widget.id);
                      Navigator.pop(context, true);
                      print('pressed');
                    } : null, // numberListの要素数が6でない場合、ボタンを無効にする
                    child: const Text('削除'),
                  ),
                                ElevatedButton(
                    onPressed: (numberList.length == 8) ? () async {
                      // 選択した数字をMinilotoCheckに渡すなどの処理を行う
                      Navigator.pop(context);
                      print('pressed');
                    } : null, // numberListの要素数が6でない場合、ボタンを無効にする
                    child: const Text('終了'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<String>> getBingoNums(int id) async {
  // データベースのパスを取得
  String path = join(await getDatabasesPath(), 'user_database.db');

  // データベースを開く
  Database database = await openDatabase(path);

  // 指定された id のレコードを取得
  List<Map<String, dynamic>> result = await database.query('bingo',
      columns: ['no', 'date', 'main1', 'main2', 'main3', 'main4', 'main5', 'main6', 'main7', 'main8'],
      where: 'id = ?',
      whereArgs: [id]);

  // データベースを閉じる
  await database.close();

  // レコードが存在する場合、main1 から main6 の値をリストで返す
  if (result.isNotEmpty) {
    print('check::${[
      result[0]['no'].toString(),
      result[0]['date'],
      result[0]['main1'],
      result[0]['main2'],
      result[0]['main3'],
      result[0]['main4'],
      result[0]['main5'],
      result[0]['main6'],
      result[0]['main7'],
      result[0]['main8'],
    ].map<String>((dynamic value) => value as String).toList()}');
    return [
      result[0]['no'].toString(),
      result[0]['date'],
      result[0]['main1'],
      result[0]['main2'],
      result[0]['main3'],
      result[0]['main4'],
      result[0]['main5'],
      result[0]['main6'],
      result[0]['main7'],
      result[0]['main8'],
    ].map<String>((dynamic value) => value as String).toList();
  } else {
    // レコードが存在しない場合は空のリストを返す
    return [];
  }
}

Future<void> updateBingoData(int id, int no, String date, List<String> preNumSetList2) async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    Database database = await openDatabase(path);

    await database.update(
      'bingo',
      {
        'no': no,
        'date': date,
        'main1': preNumSetList2[0],
        'main2': preNumSetList2[1],
        'main3': preNumSetList2[2],
        'main4': preNumSetList2[3],
        'main5': preNumSetList2[4],
        'main6': preNumSetList2[5],
        'main7': preNumSetList2[6],
        'main8': preNumSetList2[7],
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    await database.close();
  }

Future<void> deleteBingoRecord(int id) async {
  // データベースのパスを取得
  String path = join(await getDatabasesPath(), 'user_database.db');

  // データベースを開く
  Database database = await openDatabase(path);

  try {
    // 指定された id のレコードを削除
    await database.delete('bingo', where: 'id = ?', whereArgs: [id]);
  } catch (e) {
    // エラーの場合は適切な処理を行う（例: エラーメッセージを出力）
    print('Error deleting record: $e');
  } finally {
    // データベースを閉じる
    await database.close();
  }
}
