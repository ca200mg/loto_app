import 'package:flutter/material.dart';
import 'package:loto_app/bingo/bingo_graph/bingo_count_graph.dart';

class BingoStatistics extends StatelessWidget {
  final String statistics;

  const BingoStatistics(this.statistics, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TextButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>const BingoCountGraph()),//CountLoto6()),
  );
      },
      child: const Text('データ'),
      ),
    );
  }
}