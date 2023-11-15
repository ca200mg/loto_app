import 'package:flutter/material.dart';
import 'package:loto_app/dustbox/bar%20graph/bar_graph.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // あなたのデータ（Map）を定義します
  //final Map<String, int> aaa = {'1': 123, '2': 234, '3': 345};
  List<double> weeklySummary = [
    4.40,
    2.50,
    42.42,
    10.50,
    100.20,
    88.99,
    90.10
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          child: MyBarGraph(weeklySummary: weeklySummary,)),
      ),
    );
  }
}
