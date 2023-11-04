import 'package:flutter/material.dart';

import 'reset.dart';

class Setting extends StatelessWidget {
  final String setting;

  const Setting(this.setting, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TextButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Reset()),
  );
      },
      child: Text('マスターデータリセット'),
      ),
    );
  }
}