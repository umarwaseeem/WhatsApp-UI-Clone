import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../../common/widgets/custom_button.dart';
import '../../authentication/screens/login_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Welcome To WhatsApp",
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: size.height / 9),
            Image.asset("assets/images/bg.png",
                height: 340, width: 340, color: tabColor),
            SizedBox(height: size.height / 9),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Read our privacy policy, Tap 'Accept to continue' to accept terms and service ",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: "Agree and continue",
                onPressed: () {
                  navigateToLoginScreen(context);
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
