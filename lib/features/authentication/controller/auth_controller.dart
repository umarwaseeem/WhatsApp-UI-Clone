import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/authentication/repository/auth_repository.dart';

import '../../../models/user_model.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(authRepository: authRepository, ref: ref);
  },
);

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({
    required this.ref,
    required this.authRepository,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationID,
    required String userOTP,
  }) async {
    authRepository.verifyOTP(
      context: context,
      verificationID: verificationID,
      userOTP: userOTP,
    );
  }

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveDataToFireStore(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  Stream<UserModel> userDataById(String userId) {
    return authRepository.userData(userId);
  }
}
