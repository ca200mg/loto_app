import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class QooEdit extends StatefulWidget {
  int id;
  QooEdit({required this.id, Key? key}) : super(key: key);

  @override
  State<QooEdit> createState() => _QooEditState();
}

class _QooEditState extends State<QooEdit> {
  List<String> qooNums = ['0','0','0','0','0','0','0'];
  List<int> numberList = [0,0,0,0];
  final List<String> _text = ['apple', 'orange', 'melon', 'grape', 'peach'];

  @override
  void initState() {
    super.initState();
    _loadQooNums();
  }

  Future<void> _loadQooNums() async {
    List<String> nums = await getQooNums(widget.id);
    print('nums:$nums');
    setState(() {
      qooNums = nums;
      print('qooNums:$qooNums');
      numberList.clear();
      numberList.addAll(nums.sublist(2, 6).map((num) => int.parse(num)));

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
                  child: Text('第${qooNums[0]}回   ${qooNums[1]}'),
                ),
        Row(
          children: [
            // 1
            Column(
              children: [
                
                SizedBox(
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      children: [
                        
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                //toggleNumber(num);
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _text[numberList[0]],
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 400,
                  width: 60,
                  child:
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // 6つのボタンを1行に表示
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index1) {
                    int number1 = index1;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          numberList[0] = number1;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                          color: numberList[0] == number1 ? Colors.green : Colors.black12,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _text[index1],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  },
                ),
                ),
                

              ],
            ),
            // 2
            Column(
              children: [
                
                SizedBox(
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      children: [
                        
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                //toggleNumber(num);
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _text[numberList[1]],
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 400,
                  width: 60,
                  child:
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // 6つのボタンを1行に表示
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index2) {
                    int number2 = index2;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          numberList[1] = number2;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                          color: numberList[1] == number2 ? Colors.green : Colors.black12,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _text[index2],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  },
                ),
                ),
                

              ],
            ),
            // 3
            Column(
              children: [
                
                SizedBox(
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      children: [
                        
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                //toggleNumber(num);
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _text[numberList[2]],
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 400,
                  width: 60,
                  child:
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // 6つのボタンを1行に表示
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index3) {
                    int number3 = index3;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          numberList[2] = number3;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                          color: numberList[2] == number3 ? Colors.green : Colors.black12,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _text[index3],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  },
                ),
                ),
                

              ],
            ),
            // 4
            Column(
              children: [
                
                SizedBox(
                  height: 90,
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      children: [
                        
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                //toggleNumber(num);
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _text[numberList[3]],
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 400,
                  width: 60,
                  child:
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // 6つのボタンを1行に表示
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index4) {
                    int number4 = index4;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          numberList[3] = number4;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 20,
                        decoration: BoxDecoration(
                          color: numberList[3] == number4 ? Colors.green : Colors.black12,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _text[index4],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  },
                ),
                ),
                

              ],
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
                    onPressed: (numberList.length == 4) ? () async {
                      // 選択した数字をMinilotoCheckに渡すなどの処理を行う
                      List<int> preNumSetList1 = numberList;
                      List<String> preNumSetList2 = convertIntegersToFruits(numberList);
                      await updateQooData(widget.id, int.parse(qooNums[0]), qooNums[1], preNumSetList2);
                      Navigator.pop(context, true);
                      print('pressed');
                    } : null, // numberListの要素数が6でない場合、ボタンを無効にする
                    child: const Text('登録'),
                  ),
                                ElevatedButton(
                    onPressed: (numberList.length == 4) ? () async {
                      // 選択した数字をMinilotoCheckに渡すなどの処理を行う
                      await deleteQooRecord(widget.id);
                      Navigator.pop(context, true);
                      print('pressed');
                    } : null, // numberListの要素数が6でない場合、ボタンを無効にする
                    child: const Text('削除'),
                  ),
                                ElevatedButton(
                    onPressed: (numberList.length == 4) ? () async {
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


Future<List<String>> getQooNums(int id) async {
  // データベースのパスを取得
  String path = join(await getDatabasesPath(), 'user_database.db');

  // データベースを開く
  Database database = await openDatabase(path);

  // 指定された id のレコードを取得
  List<Map<String, dynamic>> result = await database.query('qoo',
      columns: ['no', 'date', 'main1', 'main2', 'main3', 'main4'],
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
    ]}');
    List<String> resultToString = [
      result[0]['no'].toString(),
      result[0]['date'],
      result[0]['main1'],
      result[0]['main2'],
      result[0]['main3'],
      result[0]['main4'],
    ];

    for (int i = 0; i < resultToString.length; i++) {
    if (resultToString[i] == 'apple') {
      resultToString[i] = '0';
    } else if (resultToString[i] == 'orange') {
      resultToString[i] = '1';
    } else if (resultToString[i] == 'melon') {
      resultToString[i] = '2';
    } else if (resultToString[i] == 'grape') {
      resultToString[i] = '3';
    } else if (resultToString[i] == 'peach') {
      resultToString[i] = '4';
    }
  }
    return resultToString;
  } else {
    // レコードが存在しない場合は空のリストを返す
    return [];
  }
}

Future<void> updateQooData(int id, int no, String date, List<String> preNumSetList2) async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    Database database = await openDatabase(path);

    await database.update(
      'qoo',
      {
        'no': no,
        'date': date,
        'main1': preNumSetList2[0],
        'main2': preNumSetList2[1],
        'main3': preNumSetList2[2],
        'main4': preNumSetList2[3],
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    await database.close();
  }

Future<void> deleteQooRecord(int id) async {
  // データベースのパスを取得
  String path = join(await getDatabasesPath(), 'user_database.db');

  // データベースを開く
  Database database = await openDatabase(path);

  try {
    // 指定された id のレコードを削除
    await database.delete('qoo', where: 'id = ?', whereArgs: [id]);
  } catch (e) {
    // エラーの場合は適切な処理を行う（例: エラーメッセージを出力）
    print('Error deleting record: $e');
  } finally {
    // データベースを閉じる
    await database.close();
  }
}

List<String> convertIntegersToFruits(List<int> inputList) {
  List<String> result = [];
  for (int number in inputList) {
    switch (number) {
      case 0:
        result.add('apple');
        break;
      case 1:
        result.add('orange');
        break;
      case 2:
        result.add('melon');
        break;
      case 3:
        result.add('grape');
        break;
      case 4:
        result.add('peach');
        break;
      default:
        // 未定義の場合は空文字列を追加するか、適切な処理を行う
        result.add('');
        break;
    }
  }
  return result;
}
