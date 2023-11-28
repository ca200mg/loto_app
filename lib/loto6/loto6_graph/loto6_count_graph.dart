import 'package:flutter/material.dart';
import 'package:loto_app/loto6/loto6_graph/loto6_bar_graph.dart';
import 'package:sqflite/sqflite.dart';

class Loto6CountGraph extends StatefulWidget {
  const Loto6CountGraph({super.key});

  @override
  State<Loto6CountGraph> createState() => _Loto6CountGraphState();
}

class _Loto6CountGraphState extends State<Loto6CountGraph> {
  List<double> countValue = []; // 初期化
  List<String> countKey = []; // 初期化
  bool sortOrNot = false;
  double maxValue = 0;

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
      maxValue = countValue.reduce((value, element) => value > element ? value : element);
    });
  }
  @override
  Widget build(BuildContext context) {
    if (countKey == null || countValue == null || countKey.isEmpty || countValue.isEmpty) {
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
              child: Loto6BarGraph(countKey: countKey, countValue: countValue,)),
            Switch(
              value: sortOrNot,
              onChanged: (value) async {
                setState(() {
                  sortOrNot = value;
                });
                await fetchData();
              },
            ),
            Expanded(
  child: ListView.builder(
    scrollDirection: Axis.vertical, // 垂直方向にスクロールするように設定
    itemCount: countKey.length,
    itemBuilder: (BuildContext context, int index) {
      double barWidth = 0;
      if (maxValue != 0) {
        barWidth = (countValue[index] / maxValue) * 200;
      }
      return Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text('${countKey[index]}: ${countValue[index].toInt()}回')),
              SizedBox(
                height: 10,
                width: barWidth,
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      );
    },
  ),
)


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
  //print(countMap);
  // 数字ごとの出現回数を示すマップを返す
  return countMap;
}

Future<Map> getKeyAndValueLists(bool sortedOrNot) async {
  // main数字ごとの出現回数を取得
  Map<String, int> counts = await countMainNumbers();
  if (sortedOrNot == true) {
    // Mapのエントリをリストに変換し、valueの昇順でソートする
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