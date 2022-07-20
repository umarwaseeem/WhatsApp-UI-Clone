import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widgets/mobile_chat.dart';

import '../colors.dart';
import 'dummy.dart';

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: info.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MobileChat(
                        name: info[index]["name"].toString(),
                      ),
                    ),
                  );
                },
                child: ContactItem(index: index),
              ),
              const Divider(color: dividerColor, indent: 85),
            ],
          );
        },
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  const ContactItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: ListTile(
        title: Text(
          info[index]["name"].toString(),
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            info[index]["message"].toString(),
            style: const TextStyle(fontSize: 15),
          ),
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            info[index]["profilePic"].toString(),
          ),
        ),
        trailing: Text(
          info[index]["time"].toString(),
          style: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ),
    );
  }
}
