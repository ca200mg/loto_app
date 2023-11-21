import 'package:flutter/material.dart';
import 'package:loto_app/miniloto/miniloto_graph/miniloto_count_graph.dart';

class MinilotoStatistics extends StatelessWidget {
  final String statistics;

  const MinilotoStatistics(this.statistics, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TextButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>const MinilotoCountGraph()),//CountLoto6()),
  );
      },
      child: const Text('データ'),
      ),
    );
  }
}