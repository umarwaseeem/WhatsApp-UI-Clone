// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_clone/features/chat/repositories/chat_repository.dart';

import '../../authentication/controller/auth_controller.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  ChatController(
    chatRepository:  chatRepository,
    ref: ref
  );
}); 

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  void sendTextMessage(
    BuildContext context,
    String text,
    String receiverUserId,
  ) {
    ref.read(userDataAuthProvider).whenData(
      (value) {
        chatRepository.sendTextMessage(
          context: context,
          text: text,
          receiverUserId: receiverUserId,
          senderUser: value!,
        );
      },
    );
  }
}
