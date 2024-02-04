import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
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
        title: const Text('通信エラー'),
      ),
      body: 
          const Center(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Text('通信できません。初回起動時などは通信環境が必要です。',
                 style: TextStyle(
                  fontSize: 15, // フォントサイズを大きくする
                  // fontWeight: FontWeight.bold, // 必要に応じてフォントの太さを設定
                  ),
                  textAlign: TextAlign.center, // テキストを中央揃えにする
                ),
                SizedBox(height: 10,),
                Text('通信できる環境でご利用ください',
                  style: TextStyle(
                  fontSize: 15, // フォントサイズを大きくする
                  // fontWeight: FontWeight.bold, // 必要に応じてフォントの太さを設定
                  ),
                  textAlign: TextAlign.center, // テキストを中央揃えにする
                ),
              ],
            ),
          ),
      );
  }

}
