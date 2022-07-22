import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/widgets/mobile_chat.dart';

import '../../../common/util/util.dart';
import '../../../models/user_model.dart';

final selectContactRepositoryProvider = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;
  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var user in userCollection.docs) {
        var userData = UserModel.fromMap(user.data());
        String selectedNumber =
            selectedContact.phones[0].number.replaceAll(" ", "");
        if (userData.phoneNumber == selectedNumber) {
          isFound = true;
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, MobileChat.routeName , arguments: userData.name);
          break;
        }

        if (!isFound) {
          showSnackBar(
            context: context,
            error: 'This number does not exist in your contacts',
          );
        }
      }
    } catch (error) {
      showSnackBar(context: context, error: error.toString());
    }
  }
}
