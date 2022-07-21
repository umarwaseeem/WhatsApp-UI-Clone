// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/authentication/screens/otp_screen.dart';
import 'package:whatsapp_clone/features/authentication/screens/user_info_screen.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import '../../../../common/util/util.dart';
import '../../../common/repositories/common_firebase_storage_repository.dart';
import '../../../screens/mobile.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    fireStore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;

  AuthRepository({
    required this.auth,
    required this.fireStore,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (String verificationId, int? resendToken) async {
            Navigator.pushNamed(
              context,
              OTPScreen.routeName,
              arguments: verificationId,
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, error: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationID,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: userOTP);
      await auth.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInfoScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, error: e.message!);
    }
  }

  void saveDataToFireStore({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String userId = auth.currentUser!.uid;
      String photoUrl =
          "https://yt3.ggpht.com/yti/APfAmoE5KUbFOwvaKuOEp51UquWMse6vPEgdrRJ803Ya6w=s88-c-k-c0x00ffffff-no-rj-mo";

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase("profilePic/$userId", profilePic);
      }

      var user = UserModel(
        uId: userId,
        name: name,
        phoneNumber: auth.currentUser!.uid,
        isOnline: true,
        profilePicture: photoUrl,
        groupId: [],
      );

      fireStore.collection("users").doc(userId).set(user.toMap());

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MobileScreen()),
        (route) => false,
      );
    } catch (error) {
      showSnackBar(context: context, error: error.toString());
    }
  }
}
