import 'package:flutter/material.dart';
import 'package:loto_app/loto6/loto6_graph/loto6_count_graph.dart';

class Loto6Statistics extends StatelessWidget {
  final String statistics;

  const Loto6Statistics(this.statistics, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TextButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>const Loto6CountGraph()),//CountLoto6()),
  );
      },
      child: const Text('データ'),
      ),
    );
  }
}