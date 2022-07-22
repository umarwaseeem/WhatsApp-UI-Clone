import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';

import '../controller/select_contacts_controller.dart';

class SelectContactScreen extends ConsumerWidget {
  const SelectContactScreen({Key? key}) : super(key: key);

  static const String routeName = "select contact screen";

  void selectContact(WidgetRef ref, Contact contact, BuildContext context) {
    ref.read(selectContactControllerProvider).selectContact(contact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text("Select Contact"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
        data: (contactList) {
          return ListView.builder(
            itemCount: contactList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  selectContact(ref, contactList[index], context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    leading: contactList[index].photo == null
                        ? null
                        : CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                MemoryImage(contactList[index].photo!),
                          ),
                    title: Text(
                      contactList[index].displayName,
                      style: const TextStyle(fontSize: 18),
                    ),
                    // subtitle: Text(contactList[index].),
                  ),
                ),
              );
            },
          );
        },
        error: (error, trace) {
          ErrorScreen(error: error.toString());
          return null;
        },
        loading: () {
          const Loader();
          return null;
        },
      ),
    );
  }
}
