import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loto_app/qoo/qoo_graph/qoo_bar_data.dart';

class QooBarGraph extends StatelessWidget {
  final List countValue;
  final List countKey;
  const QooBarGraph({super.key, required this.countKey, required this.countValue});

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    QooBarData myQoobarData = QooBarData(
      key_01:countKey[0],  value_01: countValue[0], 
      key_02:countKey[1],  value_02: countValue[1], 
      key_03:countKey[2],  value_03: countValue[2], 
      key_04:countKey[3],  value_04: countValue[3], 
      key_05:countKey[4],  value_05: countValue[4], 
      );
      myQoobarData.initializeQooBarData();
      return
    // Transform.rotate(
    //   angle: 1.5708, // 90度のラジアン
    //   child:
    SizedBox(
        width: 200,
        height: 200,
        child: BarChart(
          BarChartData(
            maxY: findMaxValue(countValue),
            minY: 0,
            titlesData: const FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getLeftTitles)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles)),
            ),
            barGroups: myQoobarData.qooBarData
            .map(
              (data) => BarChartGroupData(
              x: fluitsToNumber(data.x),
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  width: 8,
                  )
              ]))
              .toList(),
              
          ),
        ),
      );
    
  }
}
Widget getLeftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    //fontWeight: FontWeight.bold,
    fontSize: 6,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('0', style: style);
      break;
    case 50:
      text = const Text('50', style: style);
      break;
    case 100:
      text = const Text('100', style: style);
      break;
    case 150:
      text = const Text('150', style: style);
      break;
    case 200:
      text = const Text('200', style: style);
      break;
    case 250:
      text = const Text('250', style: style);
      break;
    case 300:
      text = const Text('300', style: style);
      break;
    case 350:
      text = const Text('350', style: style);
      break;
    case 400:
      text = const Text('400', style: style);
      break;
    case 600:
      text = const Text('600', style: style);
      break;
    case 650:
      text = const Text('650', style: style);
      break;
    case 700:
      text = const Text('700', style: style);
      break;
    case 750:
      text = const Text('750', style: style);
      break;
    case 800:
      text = const Text('800', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    //fontWeight: FontWeight.bold,
    fontSize: 6,
  );

  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('apple', style: style);
      break;
    case 2:
      text = const Text('orange', style: style);
      break;
    case 3:
      text = const Text('melon', style: style);
      break;
    case 4:
      text = const Text('grape', style: style);
      break;
    case 5:
      text = const Text('peach', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

double findMaxValue(List<dynamic> countValue) {
  if (countValue.isEmpty) {
    return 0; // デフォルトの返り値（任意の値に変更可能）
  }

  double max = (countValue[0] as num).toDouble(); // 最初の要素を double として設定

  for (int i = 1; i < countValue.length; i++) {
    double value = (countValue[i] as num).toDouble(); // 要素を double に変換
    if (value > max) {
      max = value; // より大きな値を見つけた場合、最大値を更新
    }
  }

  int quotient = (max / 50).ceil(); // 50で割った結果を切り上げて、50の倍数の何番目かを求める
  double nearestMultiple = quotient * 50; // 求めた位置の50の倍数を計算

  return nearestMultiple;
}

int fluitsToNumber(String fluits){
  int number;
  switch(fluits){
    case 'apple':
      number = 1;
      break;
    case 'orange':
      number = 2;
      break;
    case 'melon':
      number = 3;
      break;
    case 'grape':
      number = 4;
      break;
    case 'peach':
      number = 5;
      break;
    default:
     number = 0;
     break;
  }
  return number;
}