import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class N3Edit extends StatefulWidget {
  int id;
  N3Edit({required this.id, Key? key}) : super(key: key);

  @override
  State<N3Edit> createState() => _N3EditState();
}

class _N3EditState extends State<N3Edit> {
  List<String> n3Nums = ['0','0','0','0','0','0'];
  List<int> numberList = [0,0,0];
  int _selectedIndex = 0;
  final List<String> _options = ['ストレート', 'ボックス', 'セット', 'ミニ'];

  @override
  void initState() {
    super.initState();
    _loadN3Nums();
  }

  Future<void> _loadN3Nums() async {
    List<String> nums = await getN3Nums(widget.id);
    print('nums:$nums');
    setState(() {
      n3Nums = nums;
      print('n3Nums:$n3Nums');
      numberList.clear();
      numberList.addAll(nums.sublist(2, 5).map((num) => int.parse(num)));

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
                  child: Text('第${n3Nums[0]}回   ${n3Nums[1]}'),
                ),
        Row(
          children: [
            // 1
            Column(
              children: [
                
                SizedBox(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  numberList[0].toString(),
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
                  width: 30,
                  child:
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // 6つのボタンを1行に表示
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index1) {
                    int number1 = index1;
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
                

              ],
            ),
            // 2
            Column(
              children: [
                
                SizedBox(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  numberList[1].toString(),
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
                  width: 30,
                  child:
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // 6つのボタンを1行に表示
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index2) {
                    int number2 = index2;
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
                

              ],
            ),
            // 3
            Column(
              children: [
                
                SizedBox(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  numberList[2].toString(),
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
                  width: 30,
                  child:
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // 6つのボタンを1行に表示
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index3) {
                    int number3 = index3;
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
                

              ],
            ),
            
            Wrap(
  direction: Axis.vertical, // 縦方向に並べる
  spacing: 8.0,
  children: List<Widget>.generate(
    _options.length,
    (int index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0), // ボタンの間に余白を追加
        child: ChoiceChip(
          label: SizedBox( // テキストの余白を調整するためにSizedBoxを使用
            height: 24, // ボタンの高さ
            child: Center(
              child: Text(_options[index],
              style: const TextStyle(
                  fontSize: 12, // フォントサイズを調整
                ),
              ),
            ),
          ),
          selected: _selectedIndex == index,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedIndex = index;
              } else {
                // 選択を解除することはできないようにします
                if (_selectedIndex != index) {
                  _selectedIndex = index;
                }
              }
              print(_selectedIndex);
            });
          },
          selectedColor: Colors.blue,
          backgroundColor: Colors.grey.shade300,
          labelStyle: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    },
  ).toList(),
)

          ],
        ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (numberList.length == 3) ? () async {
                      // 選択した数字をMinilotoCheckに渡すなどの処理を行う
                      List<int> preNumSetList1 = numberList;
                      List<String> preNumSetList2 = preNumSetList1.map((num) => num.toString()).toList();
                      await updateN3Data(widget.id, int.parse(n3Nums[0]), n3Nums[1], preNumSetList2, _selectedIndex);
                      Navigator.pop(context, true);
                      print('pressed');
                    } : null, // numberListの要素数が6でない場合、ボタンを無効にする
                    child: const Text('登録'),
                  ),
                                ElevatedButton(
                    onPressed: (numberList.length == 3) ? () async {
                      // 選択した数字をMinilotoCheckに渡すなどの処理を行う
                      await deleteN3Record(widget.id);
                      Navigator.pop(context, true);
                      print('pressed');
                    } : null, // numberListの要素数が6でない場合、ボタンを無効にする
                    child: const Text('削除'),
                  ),
                                ElevatedButton(
                    onPressed: (numberList.length == 3) ? () async {
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

Future<List<String>> getN3Nums(int id) async {
  // データベースのパスを取得
  String path = join(await getDatabasesPath(), 'user_database.db');

  // データベースを開く
  Database database = await openDatabase(path);

  // 指定された id のレコードを取得
  List<Map<String, dynamic>> result = await database.query('n3',
      columns: ['no', 'date', 'main1', 'main2', 'main3', 'type'],
      where: 'id = ?',
      whereArgs: [id]);

  // データベースを閉じる
  await database.close();

  // レコードが存在する場合、main1 から main6 の値をリストで返す
  if (result.isNotEmpty) {
    print('check::${[
      result[0]['no'].toString(),
      result[0]['date'],
      result[0]['main1'].toString(),
      result[0]['main2'].toString(),
      result[0]['main3'].toString(),
      result[0]['type'].toString(),
    ].map<String>((dynamic value) => value as String).toList()}');
    return [
      result[0]['no'].toString(),
      result[0]['date'],
      result[0]['main1'].toString(),
      result[0]['main2'].toString(),
      result[0]['main3'].toString(),
      result[0]['type'].toString(),
    ].map<String>((dynamic value) => value as String).toList();
  } else {
    // レコードが存在しない場合は空のリストを返す
    return [];
  }
}

Future<void> updateN3Data(int id, int no, String date, List<String> preNumSetList2, int selectedIndex) async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    Database database = await openDatabase(path);

    await database.update(
      'n3',
      {
        'no': no,
        'date': date,
        'main1': preNumSetList2[0],
        'main2': preNumSetList2[1],
        'main3': preNumSetList2[2],
        'type': selectedIndex,
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    await database.close();
  }

Future<void> deleteN3Record(int id) async {
  // データベースのパスを取得
  String path = join(await getDatabasesPath(), 'user_database.db');

  // データベースを開く
  Database database = await openDatabase(path);

  try {
    // 指定された id のレコードを削除
    await database.delete('n3', where: 'id = ?', whereArgs: [id]);
  } catch (e) {
    // エラーの場合は適切な処理を行う（例: エラーメッセージを出力）
    print('Error deleting record: $e');
  } finally {
    // データベースを閉じる
    await database.close();
  }
}
