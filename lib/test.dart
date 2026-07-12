import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({
    super.key,
    required this.serverIPV4,
  });
  final String serverIPV4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Bienvenido(a) al exámen",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}