import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_view_model.dart';

class ForgotPasswordViewModel extends GetxController {
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final passwordVisible = false.obs;
  final confirmPasswordVisible = false.obs;

  final step = ForgotPasswordStep.email.obs;

  final otpControllers = List.generate(6, (_) => TextEditingController());
  final focusNodes = List.generate(6, (_) => FocusNode());
  final otp = ''.obs;

  void setStep(ForgotPasswordStep s) {
    step.value = s;
  }

  void submitEmail() {
    setStep(ForgotPasswordStep.code);
  }

  void submitCode() {
    final isValid = otpControllers.every((e) => e.text.isNotEmpty);
    if (!isValid) {
      Get.snackbar('Error', 'Enter full OTP');
      return;
    }
    setStep(ForgotPasswordStep.newPassword);
  }

  void submitNewPassword() {
    setStep(ForgotPasswordStep.success);
  }

  void updateOtp() {
    otp.value = otpControllers.map((e) => e.text).join();
  }

  @override
  void onClose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    for (var c in otpControllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }

    super.onClose();
  }
}