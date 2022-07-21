import 'package:flutter/material.dart';

import 'package:whatsapp_clone/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp_clone/router.dart';
import 'features/landing/screens/main_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        appBarTheme: const AppBarTheme(
          color: backgroundColor,
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
