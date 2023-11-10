import 'package:flutter/material.dart';
import 'package:loto_app/reset_c.dart';
import 'reset.dart';

class Setting extends StatelessWidget {
  final String setting;

  const Setting(this.setting, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Reset()),
                );
              },
              child: Text('マスターデータリセット'),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetC()),
                );
              },
              child: Text('ユーザデータリセット'),
            ),
          ),
        ],
      ),
    );
  }
}
