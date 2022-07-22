import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:whatsapp_clone/widgets/mobile_chat.dart';

import 'common/widgets/error.dart';
import 'features/authentication/screens/login_screen.dart';
import 'features/authentication/screens/otp_screen.dart';
import 'features/authentication/screens/user_info_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );
    case UserInfoScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInfoScreen(),
      );
    case SelectContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactScreen(),
      );
    case MobileChat.routeName:
      final userName = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => MobileChat(name: userName),
      );
    default: // - incase error in making screen, display an error screen
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(
            error: "This page does not exist",
          ),
        ),
      );
  }
}
