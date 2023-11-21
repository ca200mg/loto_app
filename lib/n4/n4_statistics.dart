import 'package:flutter/material.dart';
import 'package:loto_app/n4/n4_graph/n4_count_graph.dart';

class N4Statistics extends StatelessWidget {
  final String statistics;

  const N4Statistics(this.statistics, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TextButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>const N4CountGraph()),//CountLoto6()),
  );
      },
      child: const Text('データ'),
      ),
    );
  }
}