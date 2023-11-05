import 'package:flutter/material.dart';
import 'package:loto_app/dustbox/test/test2.dart';

class BottomTabBarSample extends StatefulWidget {
  const BottomTabBarSample({Key? key}) : super(key: key);

  @override
  State<BottomTabBarSample> createState() => _BottomTabBarSampleState();
}

class _BottomTabBarSampleState extends State<BottomTabBarSample> {
  
  int _currentIndex = 0;
  final _pages = [
    const TestA('Home'),
    const TestB('Settings'),
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
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Settings'),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}