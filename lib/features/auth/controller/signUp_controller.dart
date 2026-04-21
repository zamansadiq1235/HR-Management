// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';

class SignUpViewModel extends GetxController {
  final signUpEmailController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final signUpCompanyIdController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpConfirmPasswordController = TextEditingController();

  final acceptTerms = false.obs;
  final passwordVisible = false.obs;
  final confirmPasswordVisible = false.obs;

  void toggleAcceptTerms() {
    acceptTerms.value = !acceptTerms.value;
  }

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  String? validateConfirmPassword(String? value) {
    if (value != signUpPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void submitSignUp() {
    if (!acceptTerms.value) {
      Get.snackbar('Error', 'Accept terms first');
      return;
    }

    Get.toNamed(AppRoutes.emailVerification);
  }

  @override
  void onClose() {
    signUpEmailController.dispose();
    signUpPhoneController.dispose();
    signUpCompanyIdController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    super.onClose();
  }
}