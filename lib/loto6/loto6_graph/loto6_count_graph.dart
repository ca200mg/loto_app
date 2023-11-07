import 'package:flutter/material.dart';
import 'package:loto_app/loto6/loto6_graph/loto6_bar_graph.dart';
import 'package:sqflite/sqflite.dart';

class Loto6CountGraph extends StatefulWidget {
  const Loto6CountGraph({super.key});

  @override
  State<Loto6CountGraph> createState() => _Loto6CountGraphState();
}

class _Loto6CountGraphState extends State<Loto6CountGraph> {
  List<double> countResult = []; // 初期化

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<double> data = await getKeyAndValueLists();
    setState(() {
      countResult = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (countResult.isEmpty) {
      // データがまだ取得されていない場合はローディング表示などを行う
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('データ'),
      ),
      body: 
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200,
              width: 400,
              child: Loto6BarGraph(countResult: countResult,)),
          ],
        ),
    );
    }
  }
}

// loto6テーブル内のmain1からmain6の各数字の出現回数をカウントする関数
Future<Map<String, int>> countMainNumbers() async {
  // データベースを開く
  final Database database = await openDatabase('lotodata.db');
  // 数字ごとのカウントを格納するマップ
  Map<String, int> countMap = {};

  if (database != null) {
    // main1からmain6までそれぞれの数字の出現回数をカウントする
    for (int i = 1; i <= 6; i++) {
      // SQLクエリを実行して、各数字ごとのカウントを取得
      List<Map<String, dynamic>> result = await database.rawQuery(
        'SELECT main$i, COUNT(*) as count FROM loto6 GROUP BY main$i',
      );

      // クエリの結果を解析し、数字ごとの出現回数をマップに追加
      for (final record in result) {
        final number = record['main$i'] as String; // 数字 (文字列)
        final count = record['count'] as int; // カウント数

        // 数字ごとの出現回数をカウントマップに追加する
        countMap.update(number, (value) => value + count, ifAbsent: () => count);
      }
    }
  }
  //print(countMap);
  // 数字ごとの出現回数を示すマップを返す
  return countMap;
}

Future<List<double>> getKeyAndValueLists() async {
  // main数字ごとの出現回数を取得
  final Map<String, int> counts = await countMainNumbers();

  // keyのリストとvalueのリストを作成
  final List<int> keys = counts.keys.map(int.parse).toList(); // キーをintに変換
  final List<double> values = counts.values.map((value) => value.toDouble()).toList(); // 値をdoubleに変換
  //print(values);
  // keyとvalueのリストを含むリストを返す
  return values;//[keys, values];
}