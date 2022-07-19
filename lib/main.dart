import 'package:flutter/material.dart';

import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/screens/mobile.dart';
import 'package:whatsapp_clone/screens/web.dart';
import 'package:whatsapp_clone/widgets/res.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const ResponsiveLayout(
        mobile: MobileScreen(),
        web: WebScreen(),
      ),
    );
  }
}
