import 'package:flutter/material.dart';

import 'database.dart';
import 'database_reset.dart';
import 'loading_page.dart';

class ResetUsesr extends StatefulWidget {
  const ResetUsesr({Key? key}) : super(key: key);

  @override
  _ResetUsesrState createState() => _ResetUsesrState();
}

class _ResetUsesrState extends State<ResetUsesr> {
  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('ユーザーデータリセット'),
      ),
      body: Stack(
        children: [
          const Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Text('ユーザーデータリセットには時間がかかります。',
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
              MaterialPageRoute(builder: (context) => const LoadingScreen()),
            );

            // 非同期処理を実行（データの削除と挿入）
            await _deleteAndInsertData();

            // ローディング画面を閉じ、元の画面に戻る
            Navigator.pop(context);
          },
              child: const Text('リセットする'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAndInsertData() async {
    // setState(() {
    //   _isLoading = true;
    // });

    // データの削除
    await deleteAllDataFromAllTableUser();

    // データの挿入
    await setUserDatabase();

    // setState(() {
    //   _isLoading = false;
    // });
  }
}
