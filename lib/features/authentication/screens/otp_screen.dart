import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);
  static const routeName = "otp screen";

  void verifyOTP(BuildContext context, String userOTP, WidgetRef ref) {
    ref.read(authControllerProvider).verifyOTP(
          context: context,
          verificationID: verificationId,
          userOTP: userOTP,
        );
  }

  final String verificationId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifying your number"),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 45),
            const Text("We have sent an SMS with a code"),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "- - - - - -",
                  hintStyle: TextStyle(
                    fontSize: 50, 
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 6) {
                    verifyOTP(context, value.trim(), ref);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
