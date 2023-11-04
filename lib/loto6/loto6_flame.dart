import 'package:flutter/material.dart';

import '../setting.dart';
import 'loto6_data_display.dart';

class Loto6Flame extends StatefulWidget {
  const Loto6Flame({Key? key}) : super(key: key);

  @override
  State<Loto6Flame> createState() => _Loto6FlameState();
}

class _Loto6FlameState extends State<Loto6Flame> {
  
  int _currentIndex = 0;
  final _pages = [
    const Loto6DataDisplay('Home'),
    const Setting(),
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
              title: TextButton(
                onPressed: () {
                  
                },
                child: Text("Loto6"),),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: TextButton(
                onPressed: () {
                  
                },
                child: Text("Loto7"),),
              trailing: Icon(Icons.arrow_forward),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
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