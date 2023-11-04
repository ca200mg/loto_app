import 'package:flutter/material.dart';

import 'database.dart';
import 'database_reset.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _isLoading = false; // インジケータを制御するフラグ

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // インジケータを表示
            : TextButton(
                onPressed: () {
                  // ボタンが押された時の処理：データの削除と挿入
                  _deleteAndInsertData('1994-10-06');
                },
                child: Text('リセットする'),
              ),
      ),
    );
  }

  Future<void> _deleteAndInsertData(String date) async {
    setState(() {
      _isLoading = true; // ボタンが押されたらインジケータを表示
    });

    // データの削除
    await deleteAllDataFromAllTable();

    // データの挿入
    await fetchDataAndInsertToDatabase(date);

    setState(() {
      _isLoading = false; // 処理が完了したらインジケータを非表示にする
    });

    // 更新を反映するために画面をリロードするなどの方法を追加する場合があります
    // setStateなどを使用してUIを更新するなどが必要です
  }
}
