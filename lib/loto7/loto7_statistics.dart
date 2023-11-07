import 'package:flutter/material.dart';
import 'package:loto_app/loto6/loto6_graph/loto6_count_graph.dart';

class Loto7Statistics extends StatelessWidget {
  final String statistics;

  const Loto7Statistics(this.statistics, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TextButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>Loto6CountGraph()),//CountLoto6()),
  );
      },
      child: Text('データ'),
      ),
    );
  }
}