// loto6テーブル内のmain1からmain6の各数字の出現回数をカウントする関数
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CountLoto6 extends StatefulWidget {
  const CountLoto6({super.key});

  @override
  _CountLoto6State createState() => _CountLoto6State();
}

class _CountLoto6State extends State<CountLoto6> {
  Map<String, int> _numberCount = {};

  @override
  void initState() {
    super.initState();
    _fetchNumberCount();
  }

  Future<void> _fetchNumberCount() async {
    final result = await countMainNumbers();
    setState(() {
      _numberCount = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Number Chart')),
      body: _numberCount.isNotEmpty
          ? Column(
            children: [
              PieChart(
                  PieChartData(
                    sections: List<PieChartSectionData>.from(
                      _numberCount.keys.map(
                        (key) {
                          return PieChartSectionData(
                            value: _numberCount[key]!.toDouble(),
                            title: key,
                            radius: 100,
                          );
                        },
                      ),
                    ),
                    sectionsSpace: 5,
                    centerSpaceRadius: 30,
                  ),
                ),
            ],
          )
          : const Center(child: CircularProgressIndicator()),
    );
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

  // 数字ごとの出現回数を示すマップを返す
  return countMap;
}