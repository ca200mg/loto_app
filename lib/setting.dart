import 'package:flutter/material.dart';
import 'package:loto_app/reset_c.dart';
import 'package:loto_app/reset_user.dart';
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
                  MaterialPageRoute(builder: (context) => const Reset()),
                );
              },
              child: const Text('マスターデータリセット'),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResetC()),
                );
              },
              child: const Text('日付データリセット'),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResetUsesr()),
                );
              },
              child: const Text('ユーザーデータリセット'),
            ),
          ),
        ],
      ),
    );
  }
}
