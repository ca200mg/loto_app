import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loto_app/loto6/loto6_graph/loto6_bar_data.dart';

class Loto6BarGraph extends StatelessWidget {
  final List countResult;
  const Loto6BarGraph({super.key, required this.countResult});

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    Loto6BarData myloto6barData = Loto6BarData(
      amount_01: countResult[0], 
      amount_02: countResult[1], 
      amount_03: countResult[2], 
      amount_04: countResult[3], 
      amount_05: countResult[4], 
      amount_06: countResult[5], 
      amount_07: countResult[6],
      amount_08: countResult[7],
      amount_09: countResult[8],
      amount_10: countResult[9],
      amount_11: countResult[10],
      amount_12: countResult[11],
      amount_13: countResult[12],
      amount_14: countResult[13],
      amount_15: countResult[14],
      amount_16: countResult[15],
      amount_17: countResult[16],
      amount_18: countResult[17],
      amount_19: countResult[18],
      amount_20: countResult[19],
      amount_21: countResult[20],
      amount_22: countResult[21],
      amount_23: countResult[22],
      amount_24: countResult[23],
      amount_25: countResult[24],
      amount_26: countResult[25],
      amount_27: countResult[26],
      amount_28: countResult[27],
      amount_29: countResult[28],
      amount_30: countResult[29],
      amount_31: countResult[30],
      amount_32: countResult[31],
      amount_33: countResult[32],
      amount_34: countResult[33],
      amount_35: countResult[34],
      amount_36: countResult[35],
      amount_37: countResult[36],
      amount_38: countResult[37],
      amount_39: countResult[38],
      amount_40: countResult[39],
      amount_41: countResult[40],
      amount_42: countResult[41],
      amount_43: countResult[42],
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
            maxY: 1000,
            minY: 0,
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              //leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottomTitles)),
            ),
            barGroups: myloto6barData.loto6BarData
            .map(
              (data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(toY: data.y)
              ]))
              .toList(),
          ),
        ),
      );
    
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    //fontWeight: FontWeight.bold,
    fontSize: 5,
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
