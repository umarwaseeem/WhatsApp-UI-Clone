import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widgets/dummy.dart';

import 'my_msg.dart';
import 'sender_message.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (messages[index]["isMe"] == true) {
          return MyMessage(
            message: messages[index]["text"].toString(),
            date: messages[index]["time"].toString(),
          );
        }
        return SenderMessage(
          message: messages[index]["text"].toString(),
          date: messages[index]["time"].toString(),
        );
      },
    );
  }
}
