import 'package:flutter/material.dart';

import '../widgets/chat_appbar.dart';
import '../widgets/chat_list.dart';
import '../widgets/contacts.dart';
import '../widgets/message_input.dart';
import '../widgets/search_bar.dart';
import '../widgets/web_appbar.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: const [
                WebAppBar(),
                SearchBar(),
                Expanded(child: Contacts()),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/background.png",
                ),
              ),
            ),
            child: Column(
              children: const [
                ChatAppBar(),
                Expanded(child: ChatList()),
                MessageInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
