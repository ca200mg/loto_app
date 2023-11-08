import 'package:flutter/material.dart';

import '../loto7/loto7_flame.dart';
import 'loto6_data_display.dart';
import 'loto6_statistics.dart';
import '../setting.dart';

class Loto6Flame extends StatefulWidget {
  const Loto6Flame({Key? key}) : super(key: key);

  @override
  State<Loto6Flame> createState() => _Loto6FlameState();
}

class _Loto6FlameState extends State<Loto6Flame> {

  int _currentIndex = 0;
  final _pages = [
    const Loto6DataDisplay('Home'),
    const Loto6Statistics('Statistics'),
    const Setting('Setting'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loto6'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Text('　クジを選択してください'),
            ListTile(
              title: Text('Loto6'),
              
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Loto6Flame()),
                );
              },
            ),
            ListTile(
              title: Text('Loto7'),
              
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Loto7Flame()),
                );
              },
            ),
            ListTile(
              title: Text("Item 2"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
      body: _pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '抽選結果'),
          BottomNavigationBarItem(icon: Icon(Icons.file_open), label: '統計'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}