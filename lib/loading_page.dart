import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {

  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          Container(
            color: const Color.fromARGB(86, 0, 0, 0).withOpacity(0.6),
            // ローディング表示
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}