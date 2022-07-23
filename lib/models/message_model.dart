// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../common/enums/message_enum.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String messageId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final bool isSeen;
  Message({
    required this.senderId,
    required this.receiverId,
    required this.messageId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'messageId': messageId,
      'text': text,
      'type': type.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'isSeen': isSeen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      messageId: map['messageId'] as String,
      text: map['text'] as String,
      type: (map['type'] as String).toMessageEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      isSeen: map['isSeen'] as bool,
    );
  }
}
