import 'package:flutter/material.dart';
import 'package:loto_app/bingo/bingo_graph/bingo_bar_graph.dart';
import 'package:sqflite/sqflite.dart';

class BingoCountGraph extends StatefulWidget {
  const BingoCountGraph({super.key});

  @override
  State<BingoCountGraph> createState() => _BingoCountGraphState();
}

class _BingoCountGraphState extends State<BingoCountGraph> {
  List<double> countValue = []; // 初期化
  List<String> countKey = []; // 初期化
  bool sortOrNot = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Map data = await getKeyAndValueLists(sortOrNot);
    setState(() {
      countKey = data['keys'];
      countValue = data['values'];
    });
  }
  @override
  Widget build(BuildContext context) {
    if (countKey.isEmpty && countValue.isEmpty) {
      // データがまだ取得されていない場合はローディング表示などを行う
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('データ'),
      ),
      body: 
        Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200,
              width: 400,
              child: BingoBarGraph(countKey: countKey, countValue: countValue,)),
            Switch(
              value: sortOrNot,
              onChanged: (value) async {
                setState(() {
                  sortOrNot = value;
                });
                await fetchData();
              },
            )
          ],
        ),
    );
    }
  }
}

// bingoテーブル内のmain1からmain8の各数字の出現回数をカウントする関数
Future<Map<String, int>> countMainNumbers() async {
  // データベースを開く
  final Database database = await openDatabase('lotodata.db');
  // 数字ごとのカウントを格納するマップ
  Map<String, int> countMap = {};

  // main1からmain8までそれぞれの数字の出現回数をカウントする
  for (int i = 1; i <= 8; i++) {
    // SQLクエリを実行して、各数字ごとのカウントを取得
    List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT main$i, COUNT(*) as count FROM bingo GROUP BY main$i',
    );

    // クエリの結果を解析し、数字ごとの出現回数をマップに追加
    for (final record in result) {
      final number = record['main$i'] as String; // 数字 (文字列)
      final count = record['count'] as int; // カウント数

      // 数字ごとの出現回数をカウントマップに追加する
      countMap.update(number, (value) => value + count, ifAbsent: () => count);
    }
  }
  //print(countMap);
  // 数字ごとの出現回数を示すマップを返す
  return countMap;
}

Future<Map> getKeyAndValueLists(bool sortedOrNot) async {
  // main数字ごとの出現回数を取得
  Map<String, int> counts = await countMainNumbers();
  if (sortedOrNot == true) {
    // Mapのエントリをリストに変換し、valueの照準でソートする
    var sortedEntries = (counts.entries.toList()
    ..sort((a, b) => a.value.compareTo(b.value)));
    // ソートされたエントリを元のMapに戻す
    counts = Map.fromEntries(sortedEntries);
  }
  // keyのリストとvalueのリストを作成
  final List<String> keys = counts.keys.toList(); // キーをintに変換
  final List<double> values = counts.values.map((value) => value.toDouble()).toList(); // 値をdoubleに変換
  //print(values);
  // keyとvalueのリストを含むリストを返す
  return {'keys':keys, 'values':values};
}