import 'package:flutter/material.dart';

class TestA extends StatelessWidget {
  final String testA;

  const TestA(this.testA, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Text(testA,
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

class TestB extends StatelessWidget {
  final String testB;

  const TestB(this.testB, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(testB,
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}