import 'package:loto_app/n4/n4_graph/n4_individual_bar.dart';

class N4BarData {
  final String key_01;
  final String key_02;
  final String key_03;
  final String key_04;
  final String key_05;
  final String key_06;
  final String key_07;
  final String key_08;
  final String key_09;
  final String key_10;
  final double value_01;
  final double value_02;
  final double value_03;
  final double value_04;
  final double value_05;
  final double value_06;
  final double value_07;
  final double value_08;
  final double value_09;
  final double value_10;

  N4BarData({
  required this.key_01,
  required this.key_02,
  required this.key_03,
  required this.key_04,
  required this.key_05,
  required this.key_06,
  required this.key_07,
  required this.key_08,
  required this.key_09,
  required this.key_10,
  required this.value_01,
  required this.value_02,
  required this.value_03,
  required this.value_04,
  required this.value_05,
  required this.value_06,
  required this.value_07,
  required this.value_08,
  required this.value_09,
  required this.value_10,
  });

  List<N4IndividualBar> n4BarData = [];
  
  void initializeN4BarData() {
    n4BarData = [
      N4IndividualBar(x: key_01, y: value_01),
      N4IndividualBar(x: key_02, y: value_02),
      N4IndividualBar(x: key_03, y: value_03),
      N4IndividualBar(x: key_04, y: value_04),
      N4IndividualBar(x: key_05, y: value_05),
      N4IndividualBar(x: key_06, y: value_06),
      N4IndividualBar(x: key_07, y: value_07),
      N4IndividualBar(x: key_08, y: value_08),
      N4IndividualBar(x: key_09, y: value_09),
      N4IndividualBar(x: key_10, y: value_10),
    ];
  }
}