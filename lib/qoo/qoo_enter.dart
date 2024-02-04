import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class QooEnter extends StatefulWidget {
  final int no;
  final String date;
  const QooEnter({Key? key, required this.no, required this.date}) : super(key: key);

  @override
  State<QooEnter> createState() => _QooEnterState();
}

class _QooEnterState extends State<QooEnter> {
  List<int> numberList = [0,0,0,0];
  final List<String> _text = ['apple', 'orange', 'melon', 'grape', 'peach'];
  final int _selectedIndex = 0;
  
  void toggleNumber(int number) {
    setState(() {
    numberList[0] = number;
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
                  child: Text('第${widget.no}回   ${widget.date}'),
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
        
        ElevatedButton(
              onPressed: (numberList.length == 4) ? () async {
                // 選択した数字をLoto6Checkに渡すなどの処理を行う
                List<int> preNumSetList1 = numberList;
                //List<String> preNumSetList2 = preNumSetList1.map((num) => num.toString()).toList();
                await setNewQooNums(widget.no, widget.date, preNumSetList1,_selectedIndex, _text);
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

Future setNewQooNums(int no, String date, List<int> numSetList, int selectedIndex, List<String> text)async{
  
  String path = join(await getDatabasesPath(), 'user_database.db');
  Database database = await openDatabase(path);
  await database.insert(
    'qoo',
    {
      'no': no,
        'date': date,
        'main1': text[numSetList[0]],
        'main2': text[numSetList[1]],
        'main3': text[numSetList[2]],
        'main4': text[numSetList[3]],
    }, conflictAlgorithm: ConflictAlgorithm.ignore,);

    await database.close();
      
}