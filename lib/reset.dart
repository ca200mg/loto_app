import 'package:flutter/material.dart';

import 'database.dart';
import 'database_reset.dart';
import 'loading_page.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('マスターデータリセット'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Text('マスターデータリセットには時間がかかります。',
                 style: TextStyle(
                  fontSize: 15, // フォントサイズを大きくする
                  // fontWeight: FontWeight.bold, // 必要に応じてフォントの太さを設定
                  ),
                  textAlign: TextAlign.center, // テキストを中央揃えにする
                ),
                SizedBox(height: 10,),
                Text('リセット中は操作を行わないでください。',
                  style: TextStyle(
                  fontSize: 15, // フォントサイズを大きくする
                  // fontWeight: FontWeight.bold, // 必要に応じてフォントの太さを設定
                  ),
                  textAlign: TextAlign.center, // テキストを中央揃えにする
                ),
              ],
            ),
          ),
          Center(
            child:
             TextButton(
              onPressed: () async{
            // ローディング画面へ遷移
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoadingScreen()),
            );

            // 非同期処理を実行（データの削除と挿入）
            await _deleteAndInsertData('1994-10-06');

            // ローディング画面を閉じ、元の画面に戻る
            Navigator.pop(context);
          },
              child: Text('リセットする'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAndInsertData(String date) async {
    setState(() {
      _isLoading = true;
    });

    // データの削除
    await deleteAllDataFromAllTable();

    // データの挿入
    await fetchDataAndInsertToDatabase(date);

    setState(() {
      _isLoading = false;
    });
  }
}
