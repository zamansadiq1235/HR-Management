import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/services/storage_services.dart';

enum SignInMethod { email, employeeId, phone }

enum ForgotPasswordStep { email, code, newPassword, success }

class AuthViewModel extends GetxController {
  final emailController = TextEditingController();
  final employeeIdController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final companyIdController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final signUpCompanyIdController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpConfirmPasswordController = TextEditingController();

  final forgotPasswordEmailController = TextEditingController();
  final forgotPasswordNewPasswordController = TextEditingController();
  final forgotPasswordConfirmPasswordController = TextEditingController();
  final forgotPasswordPasswordVisible = false.obs;
  final forgotPasswordConfirmPasswordVisible = false.obs;
  final forgotPasswordStep = ForgotPasswordStep.email.obs;

  final otpControllers = List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  RxString otp = ''.obs;

  final signInMethod = SignInMethod.email.obs;
  final rememberMe = true.obs;
  final acceptTerms = false.obs;
  final passwordVisible = false.obs;
  final signUpPasswordVisible = false.obs;
  final signUpConfirmPasswordVisible = false.obs;

  final storage = StorageService();

  @override
  void onInit() {
    super.onInit();

    // 🔥 Load saved data
    rememberMe.value = storage.rememberMe;

    if (rememberMe.value) {
      emailController.text = storage.email;
      employeeIdController.text = storage.employeeId;
    }
  }

  void submitSignIn() {
    if (rememberMe.value) {
      storage.saveEmail(emailController.text);
      storage.saveEmployeeId(employeeIdController.text);
    } else {
      storage.clearRememberData();
    }

    // continue login
    storage.setLoggedIn(true);
    Get.offAllNamed(AppRoutes.navBar);
  }

  void setSignInMethod(SignInMethod method) {
    signInMethod.value = method;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  void toggleAcceptTerms() {
    acceptTerms.value = !acceptTerms.value;
  }

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void toggleSignUpPasswordVisibility() {
    signUpPasswordVisible.value = !signUpPasswordVisible.value;
  }

  void toggleSignUpConfirmPasswordVisibility() {
    signUpConfirmPasswordVisible.value = !signUpConfirmPasswordVisible.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    const emailPattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
    if (!RegExp(emailPattern).hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateEmployeeId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your employee ID';
    }
    if (value.trim().length < 3) {
      return 'Employee ID is too short';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.trim().length < 9) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateCompanyId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your company ID';
    }
    if (value.trim().length < 3) {
      return 'Please enter a valid company ID';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value.trim() != signUpPasswordController.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  void submitPhoneVerification() {
    final allFilled = otpControllers.every(
      (ctrl) => ctrl.text.trim().isNotEmpty,
    );
    if (!allFilled) {
      Get.snackbar('Verification', 'Please enter the full verification code');
      return;
    }

    Get.offNamed(AppRoutes.navBar);
  }

  void submitEmailVerification() {
    final allFilled = otpControllers.every(
      (ctrl) => ctrl.text.trim().isNotEmpty,
    );
    if (!allFilled) {
      Get.snackbar('Verification', 'Please enter the full verification code');
      return;
    }

    Get.offNamed(AppRoutes.welcome);
  }

  void resendVerificationCode() {
    Get.snackbar('Verification', 'A new verification code has been sent');
  }

  @override
  void onClose() {
    emailController.dispose();
    employeeIdController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    companyIdController.dispose();
    signUpEmailController.dispose();
    signUpPhoneController.dispose();
    signUpCompanyIdController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    for (final ctrl in otpControllers) {
      ctrl.dispose();
    }
    forgotPasswordEmailController.dispose();
    forgotPasswordNewPasswordController.dispose();
    forgotPasswordConfirmPasswordController.dispose();
    for (final node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  /// Collect OTP
  void updateOtp() {
    otp.value = otpControllers.map((e) => e.text).join();

    if (otp.value.length == 6) {
      verifyOtp();
    }
  }

  void verifyOtp() {
    Get.snackbar("OTP", "Code: ${otp.value}");
  }

  void setForgotPasswordStep(ForgotPasswordStep step) {
    forgotPasswordStep.value = step;
  }

  void toggleForgotPasswordPasswordVisibility() {
    forgotPasswordPasswordVisible.value = !forgotPasswordPasswordVisible.value;
  }

  void toggleForgotPasswordConfirmPasswordVisibility() {
    forgotPasswordConfirmPasswordVisible.value =
        !forgotPasswordConfirmPasswordVisible.value;
  }

  void submitForgotPasswordEmail() {
    setForgotPasswordStep(ForgotPasswordStep.code);
  }

  void submitForgotPasswordCode() {
    final allFilled = otpControllers.every(
      (ctrl) => ctrl.text.trim().isNotEmpty,
    );
    if (!allFilled) {
      Get.snackbar('Verification', 'Please enter the full verification code');
      return;
    }
    // Clear OTP for next use
    for (final ctrl in otpControllers) {
      ctrl.clear();
    }
    otp.value = '';
    setForgotPasswordStep(ForgotPasswordStep.newPassword);
  }

  void submitForgotPasswordNewPassword() {
    setForgotPasswordStep(ForgotPasswordStep.success);
  }

  void goToSignIn() {
    // Reset forgot password state and clear forgot password specific controllers
    forgotPasswordStep.value = ForgotPasswordStep.email;
    forgotPasswordEmailController.clear();
    forgotPasswordNewPasswordController.clear();
    forgotPasswordConfirmPasswordController.clear();
    forgotPasswordPasswordVisible.value = false;
    forgotPasswordConfirmPasswordVisible.value = false;
    Get.back();
  }

  String? validateForgotPasswordConfirm(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value.trim() != forgotPasswordNewPasswordController.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Handle paste
  void handlePaste(String value) {
    if (value.length == 6) {
      for (int i = 0; i < 6; i++) {
        otpControllers[i].text = value[i];
      }

      FocusScope.of(Get.context!).unfocus();
      updateOtp();
    }
  }
}
