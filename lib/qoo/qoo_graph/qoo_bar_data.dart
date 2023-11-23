import 'package:loto_app/qoo/qoo_graph/qoo_individual_bar.dart';

class QooBarData {
  final String key_01;
  final String key_02;
  final String key_03;
  final String key_04;
  final String key_05;
  final double value_01;
  final double value_02;
  final double value_03;
  final double value_04;
  final double value_05;

  QooBarData({
  required this.key_01,
  required this.key_02,
  required this.key_03,
  required this.key_04,
  required this.key_05,
  required this.value_01,
  required this.value_02,
  required this.value_03,
  required this.value_04,
  required this.value_05,

  });

  List<QooIndividualBar> qooBarData = [];
  
  void initializeQooBarData() {
    qooBarData = [
      QooIndividualBar(x: key_01, y: value_01),
      QooIndividualBar(x: key_02, y: value_02),
      QooIndividualBar(x: key_03, y: value_03),
      QooIndividualBar(x: key_04, y: value_04),
      QooIndividualBar(x: key_05, y: value_05),
    ];
  }
}