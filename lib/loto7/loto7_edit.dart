import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Loto7Edit extends StatefulWidget {
  final int id;
  const Loto7Edit({required this.id, Key? key}) : super(key: key);

  @override
  State<Loto7Edit> createState() => _Loto7EditState();
}

class _Loto7EditState extends State<Loto7Edit> {
  List<String> loto7Nums = [];
  Set<int> numberSet = {};

  @override
  void initState() {
    super.initState();
    _loadLoto7Nums();
  }

  Future<void> _loadLoto7Nums() async {
    List<String> nums = await getLoto7Nums(widget.id);
    setState(() {
      loto7Nums = nums;
      numberSet.addAll(nums.sublist(2, 9).map((num) => int.parse(num)));
    });
  }

  void toggleNumber(int number) {
    setState(() {
      if (numberSet.contains(number)) {
        numberSet.remove(number); // ナンバーが含まれている場合は削除
      } else if (numberSet.length < 7) {
        numberSet.add(number); // ナンバーが含まれていない場合は追加（ただし、7つ未満の場合）
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('edit'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: loto7Nums.isNotEmpty
                ? Text('第${loto7Nums[0]}回   ${loto7Nums[1]}')
                : const Text('データがありません'),
          ),
          if (loto7Nums.length >= 7)
            Row(
              children: [
                for (final i in loto7Nums.sublist(2, 9))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(i.padLeft(2, '0')),
                  ),
              ],
            ),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 4.0,
                runSpacing: 8.0,
                children: [
                  for (final num in numberSet.toList()..sort())
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          toggleNumber(num);
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
                            num.toString().padLeft(2, '0'),
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10, // 7つのボタンを1行に表示
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: 37,
            itemBuilder: (BuildContext context, int index) {
              int number = index + 1;
              return GestureDetector(
                onTap: () {
                  toggleNumber(number);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: numberSet.contains(number) ? Colors.green : Colors.black12,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    number.toString().padLeft(2, '0'),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (numberSet.length == 7) ? () async {
                      // 選択した数字をLoto7Checkに渡すなどの処理を行う
                      List<int> preNumSetList1 = numberSet.toList()..sort();
                      List<String> preNumSetList2 = preNumSetList1.map((num) => num.toString()).toList();
                      await updateLoto7Data(widget.id, int.parse(loto7Nums[0]), loto7Nums[1], preNumSetList2);
                      Navigator.pop(context, true);
                      print('pressed');
                    } : null, // numberSetの要素数が7でない場合、ボタンを無効にする
                    child: const Text('登録'),
                  ),
                                ElevatedButton(
                    onPressed: (numberSet.length == 7) ? () async {
                      // 選択した数字をLoto7Checkに渡すなどの処理を行う
                      await deleteLoto7Record(widget.id);
                      Navigator.pop(context, true);
                      print('pressed');
                    } : null, // numberSetの要素数が7でない場合、ボタンを無効にする
                    child: const Text('削除'),
                  ),
                                ElevatedButton(
                    onPressed: (numberSet.length == 7) ? () async {
                      // 選択した数字をLoto7Checkに渡すなどの処理を行う
                      Navigator.pop(context);
                      print('pressed');
                    } : null, // numberSetの要素数が7でない場合、ボタンを無効にする
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

Future<List<String>> getLoto7Nums(int id) async {
  // データベースのパスを取得
  String path = join(await getDatabasesPath(), 'user_database.db');

  // データベースを開く
  Database database = await openDatabase(path);

  // 指定された id のレコードを取得
  List<Map<String, dynamic>> result = await database.query('loto7',
      columns: ['no', 'date', 'main1', 'main2', 'main3', 'main4', 'main5', 'main6', 'main7'],
      where: 'id = ?',
      whereArgs: [id]);

  // データベースを閉じる
  await database.close();

  // レコードが存在する場合、main1 から main6 の値をリストで返す
  if (result.isNotEmpty) {
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
    ].map<String>((dynamic value) => value as String).toList();
  } else {
    // レコードが存在しない場合は空のリストを返す
    return [];
  }
}

Future<void> updateLoto7Data(int id, int no, String date, List<String> preNumSetList2) async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    Database database = await openDatabase(path);

    await database.update(
      'loto7',
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
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    await database.close();
  }

Future<void> deleteLoto7Record(int id) async {
  // データベースのパスを取得
  String path = join(await getDatabasesPath(), 'user_database.db');

  // データベースを開く
  Database database = await openDatabase(path);

  try {
    // 指定された id のレコードを削除
    await database.delete('loto7', where: 'id = ?', whereArgs: [id]);
  } catch (e) {
    // エラーの場合は適切な処理を行う（例: エラーメッセージを出力）
    print('Error deleting record: $e');
  } finally {
    // データベースを閉じる
    await database.close();
  }
}
