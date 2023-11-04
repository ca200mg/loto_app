import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  final String statistics;

  const Statistics(this.statistics, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
          children: [
            _menuItem("メニュー1", Icon(Icons.settings)),
            _menuItem("メニュー2", Icon(Icons.map)),
            _menuItem("メニュー3", Icon(Icons.room)),
            _menuItem("メニュー4", Icon(Icons.local_shipping)),
            _menuItem("メニュー5", Icon(Icons.airplanemode_active)),
          ]
        ),
    );
  }
  Widget _menuItem(String title, Icon icon) {
    return GestureDetector(
      child:Container(
        padding: EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child:icon,
            ),
            Text(
              title,
              style: TextStyle(
                color:Colors.black,
                fontSize: 18.0
              ),
            ),
          ],
        )
      ),
      onTap: () {
        print("onTap called.");
      },
    );
  }
}