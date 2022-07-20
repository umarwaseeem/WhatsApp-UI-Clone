import 'package:flutter/material.dart';

import '../colors.dart';

class SenderMessage extends StatelessWidget {
  const SenderMessage({Key? key, required this.message, required this.date})
      : super(key: key);

  final String message;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: senderMessageColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 30, bottom: 20, top: 5),
                child: Text(message, style: const TextStyle(fontSize: 15)),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      date,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.white60),
                    ),
                    // const SizedBox(width: 5),
                    // const Icon(Icons.done_all, color: Colors.blue, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
