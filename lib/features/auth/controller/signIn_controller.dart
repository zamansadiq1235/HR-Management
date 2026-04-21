// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import 'auth_view_model.dart';

class SignInViewModel extends GetxController {
  final emailController = TextEditingController();
  final employeeIdController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  final signInMethod = SignInMethod.email.obs;
  final rememberMe = true.obs;
  final passwordVisible = false.obs;

  void setSignInMethod(SignInMethod method) {
    signInMethod.value = method;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void submitSignIn() {
    if (signInMethod.value == SignInMethod.phone) {
      Get.toNamed(AppRoutes.phoneVerification);
      return;
    }
    Get.offNamed(AppRoutes.navBar);
  }

  @override
  void onClose() {
    emailController.dispose();
    employeeIdController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}