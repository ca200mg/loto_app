import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MinilotoEnter extends StatefulWidget {
  final int no;
  final String date;
  const MinilotoEnter({Key? key, required this.no, required this.date}) : super(key: key);

  @override
  State<MinilotoEnter> createState() => _MinilotoEnterState();
}

class _MinilotoEnterState extends State<MinilotoEnter> {
  Set<int> numberSet = {};

  void toggleNumber(int number) {
    setState(() {
    if (numberSet.contains(number)) {
      numberSet.remove(number); // ナンバーが含まれている場合は削除
    } else if (numberSet.length < 5) {
      numberSet.add(number); // ナンバーが含まれていない場合は追加（ただし、6つ未満の場合）
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
      title: const Text('番号入力'),
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('第${widget.no}回   ${widget.date}'),
        ),
        SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
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
            crossAxisCount: 10, // 6つのボタンを1行に表示
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: 31,
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
        ElevatedButton(
          onPressed: (numberSet.length == 5) ? () async {
            // 選択した数字をMinilotoCheckに渡すなどの処理を行う
            List<int> preNumSetList1 = numberSet.toList()..sort();
            List<String> preNumSetList2 = preNumSetList1.map((num) => num.toString()).toList();
            await setNewMinilotoNums(widget.no, widget.date, preNumSetList2);
            Navigator.pop(context, true);
            print('pressed');
          } : null, // numberSetの要素数が6でない場合、ボタンを無効にする
          child: const Text('登録'),
        ),

      ],
    ),
  );
}
//numberSet.toList()..sort()
}

Future setNewMinilotoNums(int no, String date, List<String> numSetList)async{
  
  String path = join(await getDatabasesPath(), 'user_database.db');
  Database database = await openDatabase(path);
  await database.insert(
    'miniloto',
    {
      'no': no,
        'date': date,
        'main1': numSetList[0],
        'main2': numSetList[1],
        'main3': numSetList[2],
        'main4': numSetList[3],
        'main5': numSetList[4],
    }, conflictAlgorithm: ConflictAlgorithm.ignore,);

    await database.close();
      
}