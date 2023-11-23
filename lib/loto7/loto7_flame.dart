import 'package:flutter/material.dart';
import 'package:loto_app/loto7/loto7_check.dart';
import 'package:loto_app/miniloto/miniloto_flame.dart';
import 'package:loto_app/n3/n3_flame.dart';
import 'package:loto_app/n4/n4_flame.dart';
import 'package:loto_app/qoo/qoo_flame.dart';

import '../loto6/loto6_flame.dart';
import '../setting.dart';
import 'loto7_data_display.dart';
import 'loto7_statistics.dart';

class Loto7Flame extends StatefulWidget {
  const Loto7Flame({Key? key}) : super(key: key);

  @override
  State<Loto7Flame> createState() => _Loto7FlameState();
}

class _Loto7FlameState extends State<Loto7Flame> {

  int _currentIndex = 0;
  final _pages = [
    const Loto7DataDisplay('Home'),
    const Loto7Check('loto7Check'),
    const Loto7Statistics('Statistics'),
    const Setting('Setting'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loto7'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            const Text('　クジを選択してください'),
            ListTile(
              title: const Text('Loto6'),
              
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Loto6Flame()),
                );
              },
            ),
            ListTile(
              title: const Text('Loto7'),
              
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Loto7Flame()),
                );
              },
            ),
            ListTile(
              title: const Text('Miniloto'),
              
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MinilotoFlame()),
                );
              },
            ),
            ListTile(
              title: const Text('N4'),
              
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const N4Flame()),
                );
              },
            ),
            ListTile(
              title: const Text('N3'),
              
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const N3Flame()),
                );
              },
            ),
            ListTile(
              title: const Text('Qoo'),
              
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const QooFlame()),
                );
              },
            ),
            const ListTile(
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '当選確認'),
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