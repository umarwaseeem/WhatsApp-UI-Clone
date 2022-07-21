import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_clone/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp_clone/features/authentication/controller/auth_controller.dart';
import 'package:whatsapp_clone/router.dart';
import 'package:whatsapp_clone/screens/mobile.dart';
import 'common/widgets/error.dart';
import 'common/widgets/loader.dart';
import 'features/landing/screens/main_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      home: ref.watch(userDataAuthProvider).when(
        data: (user) {
          if (user == null) {
            return const MainScreen();
          }
          return const MobileScreen();
        },
        error: (error, trace) {
          return ErrorScreen(error: error.toString());
        },
        loading: () {
          return const Center(child: Loader());
        },
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
