import 'package:flutter/material.dart';
import 'package:loto_app/loto6/loto6_graph/loto6_bar_graph.dart';

class Loto6CountGraph extends StatefulWidget {
  const Loto6CountGraph({super.key});

  @override
  State<Loto6CountGraph> createState() => _Loto6CountGraphState();
}

class _Loto6CountGraphState extends State<Loto6CountGraph> {
  // あなたのデータ（Map）を定義します
  //final Map<String, int> aaa = {'1': 123, '2': 234, '3': 345};
  List<double> countResult = [
    123,456,789,234,567,890,345,678,901,456,789,234,567,890,345,678,901,123,456,789,234,567,890,345,678,901,123,456,789,234,567,890,345,678,901,123,456,789,234,567,890,345,678,901,

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('カウント'),
      ),
      body: 
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 400,
              width: 400,
              child: Loto6BarGraph(countResult: countResult,)),
          ],
        ),
      
    );
  }
}