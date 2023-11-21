import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class N3Enter extends StatefulWidget {
  final int no;
  final String date;
  const N3Enter({Key? key, required this.no, required this.date}) : super(key: key);

  @override
  State<N3Enter> createState() => _N3EnterState();
}

class _N3EnterState extends State<N3Enter> {
  List<int> numberList = [0,0,0];
  int _selectedIndex = 0;
  final List<String> _options = ['ストレート', 'ボックス', 'セット', 'ミニ'];
  
  // void toggleNumber(int number) {
  //   setState(() {
  //   numberList[0] = number;
  // });
  // }

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
                  child: Text('第${widget.no}回   ${widget.date}'),
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
        
        ElevatedButton(
              onPressed: (numberList.length == 3) ? () async {
                // 選択した数字をLoto6Checkに渡すなどの処理を行う
                List<int> preNumSetList1 = numberList;
                //List<String> preNumSetList2 = preNumSetList1.map((num) => num.toString()).toList();
                await setNewN3Nums(widget.no, widget.date, preNumSetList1,_selectedIndex);
                Navigator.pop(context, true);
                print('pressed');
              } : null, // numberListの要素数が6でない場合、ボタンを無効にする
              child: const Text('登録'),
            ),
      ],
    ),
    
  );
}
//numberList
}

Future setNewN3Nums(int no, String date, List<int> numSetList, int selectedIndex)async{
  
  String path = join(await getDatabasesPath(), 'user_database.db');
  Database database = await openDatabase(path);
  await database.insert(
    'n3',
    {
      'no': no,
        'date': date,
        'main1': numSetList[0],
        'main2': numSetList[1],
        'main3': numSetList[2],
        'type': selectedIndex,
    }, conflictAlgorithm: ConflictAlgorithm.ignore,);

    await database.close();
      
}