import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {

  LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          Container(
            color: const Color.fromARGB(86, 0, 0, 0).withOpacity(0.6),
            // ローディング表示
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}