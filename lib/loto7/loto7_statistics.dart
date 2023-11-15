import 'package:flutter/material.dart';
import 'package:loto_app/loto7/loto7_gragh/loto7_count_graph.dart';

class Loto7Statistics extends StatelessWidget {
  final String statistics;

  const Loto7Statistics(this.statistics, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TextButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>const Loto7CountGraph()),//CountLoto6()),
  );
      },
      child: const Text('データ'),
      ),
    );
  }
}