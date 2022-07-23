// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';

import '../../../common/util/util.dart';
import '../../../models/chat_contact.dart';
import '../../../models/message_model.dart';
import '../../../models/user_model.dart';

final chatRepositoryProvider = Provider((ref) {
  ChatRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  void _saveDataToContactsSubCollection(
    UserModel senderUserData,
    UserModel receiverUserData,
    String text,
    DateTime timeSent,
    String receiverUserId,
  ) async {
    var receiverChatContact = ChatContact(
      name: senderUserData.name,
      profilePicture: senderUserData.profilePicture,
      contactId: senderUserData.uId,
      timeSent: timeSent,
      lastMessage: text,
    );

    await firestore
        .collection("users")
        .doc(receiverUserId)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .set(
          receiverChatContact.toMap(),
        );

    var senderChatContact = ChatContact(
      name: receiverUserData.name,
      profilePicture: receiverUserData.profilePicture,
      contactId: receiverUserData.uId,
      timeSent: timeSent,
      lastMessage: text,
    );

    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(receiverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessageToMessageSubCollection({
    required String receiverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String userName,
    required String receiverUserName,
    required MessageEnum messageType,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      receiverId: receiverUserId,
      messageId: messageId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      isSeen: false,
    );

    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(receiverUserId)
        .collection("messages")
        .doc(messageId)
        .set(
          message.toMap(),
        );

    await firestore
        .collection("users")
        .doc(receiverUserId)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .collection("messages")
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
    required UserModel senderUser,
  }) async {
    try {
      var timeSent = DateTime.now();

      UserModel receiverUserData;

      var userDataMap =
          await firestore.collection("users").doc(receiverUserId).get();

      receiverUserData = UserModel.fromMap(userDataMap.data()!);

      _saveDataToContactsSubCollection(
        senderUser,
        receiverUserData,
        text,
        timeSent,
        receiverUserId,
      );

      var messageId = const Uuid().v4();

      _saveMessageToMessageSubCollection(
        receiverUserId: receiverUserId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        userName: senderUser.name,
        receiverUserName: receiverUserData.name,
        messageType: MessageEnum.text,
      );
    } catch (error) {
      showSnackBar(context: context, error: error.toString());
    }
  }
}
