import 'package:flutter/material.dart';

import '../widgets/contacts.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Contacts(),
    );
  }
}
