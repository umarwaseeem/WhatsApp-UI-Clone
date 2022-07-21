import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);
  static const routeName = "otp screen";

  final String verificationId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text("OTP Screen"),
    );
  }
}
