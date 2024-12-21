import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BingoEnter extends StatefulWidget {
  final int no;
  final String date;
  const BingoEnter({Key? key, required this.no, required this.date}) : super(key: key);

  @override
  State<BingoEnter> createState() => _BingoEnterState();
}

class _BingoEnterState extends State<BingoEnter> {
  List<int> numberList = [1,6,11,16,21,26,31,36];
  double height =60;
  double width = 300;
  
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
    body: Center(
      child: Column(
        children: [
          Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('第${widget.no}回   ${widget.date}'),
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
          
          ElevatedButton(
                onPressed: (numberList.length == 8) ? () async {
                  // 選択した数字をLoto6Checkに渡すなどの処理を行う
                  List<int> preNumSetList1 = numberList;
                  //List<String> preNumSetList2 = preNumSetList1.map((num) => num.toString()).toList();
                  await setNewBingoNums(widget.no, widget.date, preNumSetList1);
                  Navigator.pop(context, true);
                  print('pressed');
                } : null, // numberListの要素数が6でない場合、ボタンを無効にする
                child: const Text('登録'),
              ),
        ],
      ),
    ),
    
  );
}
//numberList
}

Future setNewBingoNums(int no, String date, List<int> numSetList)async{
  
  String path = join(await getDatabasesPath(), 'user_database.db');
  Database database = await openDatabase(path);
  await database.insert(
    'bingo',
    {
      'no': no,
        'date': date,
        'main1': numSetList[0],
        'main2': numSetList[1],
        'main3': numSetList[2],
        'main4': numSetList[3],
        'main5': numSetList[4],
        'main6': numSetList[5],
        'main7': numSetList[6],
        'main8': numSetList[7],
    }, conflictAlgorithm: ConflictAlgorithm.ignore,);

    await database.close();
      
}