import 'package:flutter/material.dart';
import 'package:loto_app/bingo/bingo_check.dart';
import 'package:loto_app/bingo/bingo_data_display.dart';
import 'package:loto_app/bingo/bingo_statistics.dart';
import 'package:loto_app/loto6/loto6_flame.dart';
import 'package:loto_app/loto7/loto7_flame.dart';
import 'package:loto_app/miniloto/miniloto_flame.dart';
import 'package:loto_app/n3/n3_flame.dart';
import 'package:loto_app/n4/n4_flame.dart';
import 'package:loto_app/qoo/qoo_flame.dart';
import 'package:loto_app/setting.dart';

class BingoFlame extends StatefulWidget {
  const BingoFlame({Key? key}) : super(key: key);

  @override
  State<BingoFlame> createState() => _BingoFlameState();
}

class _BingoFlameState extends State<BingoFlame> {

  int _currentIndex = 0;
  final _pages = [
    const BingoDataDisplay('Home'),
    const BingoCheck('BingoCheck'),
    const BingoStatistics('Statistics'),
    const Setting('Setting'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bingo'),
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
            ListTile(
              title: const Text('Bingo'),
              
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const BingoFlame()),
                );
              },
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