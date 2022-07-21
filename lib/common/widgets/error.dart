import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error Screen")),
      body: Center(
        child: Column(
          children: [
            Text(error),
          ],
        ),
      ),
    );
  }
}
