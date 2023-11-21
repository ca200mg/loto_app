import 'package:flutter/material.dart';
import 'package:loto_app/n3/n3_graph/n3_count_graph.dart';

class N3Statistics extends StatelessWidget {
  final String statistics;

  const N3Statistics(this.statistics, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TextButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>const N3CountGraph()),//CountLoto6()),
  );
      },
      child: const Text('データ'),
      ),
    );
  }
}