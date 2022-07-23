import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/widgets/chat_list.dart';

import '../../authentication/controller/auth_controller.dart';
import '../../../models/user_model.dart';
import '../widgets/bottom_chat_field.dart';

class MobileChat extends ConsumerWidget {
  const MobileChat({Key? key, required this.name, required this.id})
      : super(key: key);

  final String name;
  final String id;

  static const routeName = "mobile chat screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<UserModel>(
          stream: ref.watch(authControllerProvider).userDataById(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // if (snapshot.hasError) {
              //   return const ErrorScreen(error: "Error in fetching user data");
              // }
              return const Loader();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(
                  snapshot.data!.isOnline ? "Online" : "Offline",
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            );
          },
        ),
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: ChatList()),
          BottomChatField(
            receiverUserId: id,
          ),
        ],
      ),
    );
  }
}
