import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loto_app/database.dart';
import 'package:loto_app/models/api.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ParsedData apis = ParsedData(bingo5: [], loto6: [], loto7: [], miniloto: [], n3: [], n4: [], qoo: []);
  final TextEditingController _textController = TextEditingController(); // 入力値を管理するコントローラ

  Future<ParsedData> Loto(String date) async {
    //1.http通信に必要なデータ
    final uri = Uri.https('appsicoded.com', 'get_loto_results', {
      'pw': 'doraemon810',
      'date': '$date',
    });
    final http.Response res = await http.get(uri, headers: {
      
    });
    //print(res.body);
    if (res.statusCode == 200) {
      //モデルクラスへの変換
      // JSON データをパースしてクラスに変換する
      final parsedData = ParsedData.fromJson(json.decode(res.body));
      // パースされたデータを使用する
      debugPrint('${parsedData.bingo5}');
      for (var bingo in parsedData.bingo5) {
       debugPrint("Bingo5 - Date: ${bingo.date}, Main Numbers: ${bingo.main1}, ${bingo.main2}, ${bingo.main3}, ${bingo.main4}, ${bingo.main5}, ${bingo.main6}, ${bingo.main7}, ${bingo.main8}");
      }
      //return Api.fromJson(jsonDecode(res.body))).toList();
      return parsedData;
    } else {
      return ParsedData(bingo5: [], loto6: [], loto7: [], miniloto: [], n3: [], n4: [], qoo: []);
    }
    //2.リクエストを送る
    //3.戻り値をApiクラスの配列に変換
    //4.変換したApiクラスの配列を返す(return)
    
  }
  @override
void initState() {
  super.initState();
  fetchDataAndInsertToDatabase(2023-10-10).then((_) {
    setState(() {}); // setStateを使ってウィジェットを再構築する
  });
}

Widget _buildBody() {
  if (apis.bingo5.isEmpty) {
    return Center(
      child: CircularProgressIndicator(), // データを取得中にプログレスインジケーターを表示
    );
  } else {
    return ListView.builder(
      itemCount: apis.bingo5.length,
      itemBuilder: (BuildContext context, int index) {
        final bingo = apis.bingo5[index];
        return ListTile(
          title: Text("Bingo5 - Date: ${bingo.date}"),
          subtitle: Text("Main Numbers: ${bingo.main1}, ${bingo.main2}, ${bingo.main3}, ${bingo.main4}, ${bingo.main5}, ${bingo.main6}, ${bingo.main7}, ${bingo.main8}"),
        );
      },
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 36,
          ),
          child: TextField(
            onSubmitted: (String value) async {
              final results = await Loto(value);
              setState(() {
                apis = results;
                _textController.clear();
              });
            },
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: 'Enter a search term',
            ),
          ),
        ),
        Expanded(
          child: _buildBody(), // 関数を使ってウィジェットを構築
        ),
      ],
    ),
  );
}

}