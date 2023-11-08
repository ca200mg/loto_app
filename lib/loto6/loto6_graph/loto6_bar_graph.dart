import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loto_app/loto6/loto6_graph/loto6_bar_data.dart';

class Loto6BarGraph extends StatelessWidget {
  final List countValue;
  final List countKey;
  const Loto6BarGraph({super.key, required this.countKey, required this.countValue});

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    Loto6BarData myloto6barData = Loto6BarData(
      key_01:countKey[0],  value_01: countValue[0], 
      key_02:countKey[1],  value_02: countValue[1], 
      key_03:countKey[2],  value_03: countValue[2], 
      key_04:countKey[3],  value_04: countValue[3], 
      key_05:countKey[4],  value_05: countValue[4], 
      key_06:countKey[5],  value_06: countValue[5], 
      key_07:countKey[6],  value_07: countValue[6],
      key_08:countKey[7],  value_08: countValue[7],
      key_09:countKey[8],  value_09: countValue[8],
      key_10:countKey[9],  value_10: countValue[9],
      key_11:countKey[10], value_11: countValue[10],
      key_12:countKey[11], value_12: countValue[11],
      key_13:countKey[12], value_13: countValue[12],
      key_14:countKey[13], value_14: countValue[13],
      key_15:countKey[14], value_15: countValue[14],
      key_16:countKey[15], value_16: countValue[15],
      key_17:countKey[16], value_17: countValue[16],
      key_18:countKey[17], value_18: countValue[17],
      key_19:countKey[18], value_19: countValue[18],
      key_20:countKey[19], value_20: countValue[19],
      key_21:countKey[20], value_21: countValue[20],
      key_22:countKey[21], value_22: countValue[21],
      key_23:countKey[22], value_23: countValue[22],
      key_24:countKey[23], value_24: countValue[23],
      key_25:countKey[24], value_25: countValue[24],
      key_26:countKey[25], value_26: countValue[25],
      key_27:countKey[26], value_27: countValue[26],
      key_28:countKey[27], value_28: countValue[27],
      key_29:countKey[28], value_29: countValue[28],
      key_30:countKey[29], value_30: countValue[29],
      key_31:countKey[30], value_31: countValue[30],
      key_32:countKey[31], value_32: countValue[31],
      key_33:countKey[32], value_33: countValue[32],
      key_34:countKey[33], value_34: countValue[33],
      key_35:countKey[34], value_35: countValue[34],
      key_36:countKey[35], value_36: countValue[35],
      key_37:countKey[36], value_37: countValue[36],
      key_38:countKey[37], value_38: countValue[37],
      key_39:countKey[38], value_39: countValue[38],
      key_40:countKey[39], value_40: countValue[39],
      key_41:countKey[40], value_41: countValue[40],
      key_42:countKey[41], value_42: countValue[41],
      key_43:countKey[42], value_43: countValue[42],
      );
      myloto6barData.initializeLoto6BarData();
      return
    // Transform.rotate(
    //   angle: 1.5708, // 90度のラジアン
    //   child:
    Container(
        width: 200,
        height: 200,
        child: BarChart(
          BarChartData(
            maxY: findMaxValue(countValue),
            minY: 0,
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getLeftTitles)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles)),
            ),
            barGroups: myloto6barData.loto6BarData
            .map(
              (data) => BarChartGroupData(
              x: int.parse(data.x),
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
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
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
      text = const Text('01', style: style);
      break;
    case 2:
      text = const Text('02', style: style);
      break;
    case 3:
      text = const Text('03', style: style);
      break;
    case 4:
      text = const Text('04', style: style);
      break;
    case 5:
      text = const Text('05', style: style);
      break;
    case 6:
      text = const Text('06', style: style);
      break;
    case 7:
      text = const Text('07', style: style);
      break;
    case 8:
      text = const Text('08', style: style);
      break;
    case 9:
      text = const Text('09', style: style);
      break;
    case 10:
      text = const Text('10', style: style);
      break;
    case 11:
      text = const Text('11', style: style);
      break;
    case 12:
      text = const Text('12', style: style);
      break;
    case 13:
      text = const Text('13', style: style);
      break;
    case 14:
      text = const Text('14', style: style);
      break;
    case 15:
      text = const Text('15', style: style);
      break;
    case 16:
      text = const Text('16', style: style);
      break;
    case 17:
      text = const Text('17', style: style);
      break;
    case 18:
      text = const Text('18', style: style);
      break;
    case 19:
      text = const Text('19', style: style);
      break;
    case 20:
      text = const Text('20', style: style);
      break;
    case 21:
      text = const Text('21', style: style);
      break;
    case 22:
      text = const Text('22', style: style);
      break;
    case 23:
      text = const Text('23', style: style);
      break;
    case 24:
      text = const Text('24', style: style);
      break;
    case 25:
      text = const Text('25', style: style);
      break;
    case 26:
      text = const Text('26', style: style);
      break;
    case 27:
      text = const Text('27', style: style);
      break;
    case 28:
      text = const Text('28', style: style);
      break;
    case 29:
      text = const Text('29', style: style);
      break;
    case 30:
      text = const Text('30', style: style);
      break;
    case 31:
      text = const Text('31', style: style);
      break;
    case 32:
      text = const Text('32', style: style);
      break;
    case 33:
      text = const Text('33', style: style);
      break;
    case 34:
      text = const Text('34', style: style);
      break;
    case 35:
      text = const Text('35', style: style);
      break;
    case 36:
      text = const Text('36', style: style);
      break;
    case 37:
      text = const Text('37', style: style);
      break;
    case 38:
      text = const Text('38', style: style);
      break;
    case 39:
      text = const Text('39', style: style);
      break;
    case 40:
      text = const Text('40', style: style);
      break;
    case 41:
      text = const Text('41', style: style);
      break;
    case 42:
      text = const Text('42', style: style);
      break;
    case 43:
      text = const Text('43', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
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