import 'package:flutter/material.dart';
import 'package:loto_app/qoo/qoo_graph/qoo_count_graph.dart';

class QooStatistics extends StatelessWidget {
  final String statistics;

  const QooStatistics(this.statistics, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TextButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>const QooCountGraph()),//CountLoto6()),
  );
      },
      child: const Text('データ'),
      ),
    );
  }
}