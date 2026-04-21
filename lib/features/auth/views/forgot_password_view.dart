// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../controller/auth_view_model.dart';
import '../widgets/floating_icon_card.dart';
import '../widgets/forgot_password_step_header.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/resend_code_row.dart';

class ForgotPasswordView extends GetView<AuthViewModel> {
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  ForgotPasswordView({super.key});

  // helpers 

  String _stepTitle(ForgotPasswordStep step) {
    switch (step) {
      case ForgotPasswordStep.email:
        return 'Forgot Password';
      case ForgotPasswordStep.code:
        return 'Forgot Password';
      case ForgotPasswordStep.newPassword:
        return 'Set a New Password';
      case ForgotPasswordStep.success:
        return 'Password Has Been Created';
    }
  }

  String _stepSubtitle(ForgotPasswordStep step) {
    switch (step) {
      case ForgotPasswordStep.email:
        return 'A verification code will be sent to your email to reset your password.';
      case ForgotPasswordStep.code:
        return 'A reset code has been sent to '
            '${controller.forgotPasswordEmailController.text}, '
            'check your email to continue the password reset process.';
      case ForgotPasswordStep.newPassword:
        return 'Please set a new password to secure your Work Mate account.';
      case ForgotPasswordStep.success:
        return 'To log in to your account, click the Sign In button and enter '
            'your email along with your new password.';
    }
  }

  /// Floating icon bottom offset per step
  double _iconBottom(ForgotPasswordStep step) {
    switch (step) {
      case ForgotPasswordStep.email:
        return 298.h;
      case ForgotPasswordStep.code:
        return 330.h;
      case ForgotPasswordStep.newPassword:
        return 398.h;
      case ForgotPasswordStep.success:
        return 198.h;
    }
  }

  //  step bodies 

  Widget _buildEmailStep() {
    return Form(
      key: _emailFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          CustomTextfield(
            label: 'Email',
            hintText: 'My email',
            controller: controller.forgotPasswordEmailController,
            validator: controller.validateEmail,
            keyboardType: TextInputType.emailAddress,
            isPassword: false,
            obscureText: false,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                AppAssets.emailicon,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          CustomButton(
            text: 'Send Verification Code',
            onPressed: () {
              final isValid = _emailFormKey.currentState?.validate() ?? false;
              if (isValid) controller.submitForgotPasswordEmail();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOtpStep() {
    return Column(
      children: [
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            controller.otpControllers.length,
            (index) => OtpInputField(
              controller: controller.otpControllers[index],
              focusNode: controller.focusNodes[index],
              index: index,
              totalFields: controller.otpControllers.length,
              allFocusNodes: controller.focusNodes,
              onChanged: controller.updateOtp,
              onPaste: controller.handlePaste,
            ),
          ),
        ),
        SizedBox(height: 18.h),
        ResendCodeRow(
          onResendTap: () => Get.snackbar(
            'Resend Code',
            'A new reset code has been requested',
          ),
        ),
        SizedBox(height: 24.h),
        CustomButton(
          text: 'Submit',
          onPressed: controller.submitForgotPasswordCode,
        ),
      ],
    );
  }

  Widget _buildNewPasswordStep() {
    return Form(
      key: _passwordFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          /// Password field
          Obx(
            () => CustomTextfield(
              label: 'Password',
              hintText: 'Input Password',
              obscureText: !controller.passwordVisible.value,
              controller: controller.forgotPasswordNewPasswordController,
              validator: controller.validatePassword,
              keyboardType: TextInputType.text,
              isPassword: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  AppAssets.passwordicon,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.forgotPasswordPasswordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.primary,
                ),
                onPressed: controller.toggleForgotPasswordPasswordVisibility,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          /// Confirm password field
          Obx(
            () => CustomTextfield(
              label: 'Confirm Password',
              hintText: 'Re Enter Your Password',
              obscureText: !controller.passwordVisible.value,
              controller: controller.forgotPasswordConfirmPasswordController,
              validator: controller.validateForgotPasswordConfirm,
              keyboardType: TextInputType.text,
              isPassword: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  AppAssets.passwordicon,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  controller.forgotPasswordConfirmPasswordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.primary,
                ),
                onPressed:
                    controller.toggleForgotPasswordConfirmPasswordVisibility,
              ),
            ),
          ),

          SizedBox(height: 24.h),
          CustomButton(
            text: 'Submit',
            onPressed: () {
              final isValid =
                  _passwordFormKey.currentState?.validate() ?? false;
              if (isValid) controller.submitForgotPasswordNewPassword();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessStep() {
    return Column(
      children: [
        SizedBox(height: 12.h),
        CustomButton(text: 'Sign In', onPressed: controller.goToSignIn),
      ],
    );
  }

  // ─── build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          final step = controller.forgotPasswordStep.value;
          return Stack(
            children: [
              // ── Bottom white card ──────────────────────────────────────
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 24.r,
                        offset: Offset(0, -6.h),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 14.h),

                        // ── Step header (drag handle + title + subtitle) ──
                        ForgotPasswordStepHeader(
                          title: _stepTitle(step),
                          subtitle: _stepSubtitle(step),
                        ),

                        SizedBox(height: 20.h),

                        // ── Step body ─────────────────────────────────────
                        if (step == ForgotPasswordStep.email) _buildEmailStep(),

                        if (step == ForgotPasswordStep.code) _buildOtpStep(),

                        if (step == ForgotPasswordStep.newPassword)
                          _buildNewPasswordStep(),

                        if (step == ForgotPasswordStep.success)
                          _buildSuccessStep(),

                        SizedBox(height: 28.h),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Floating purple icon card ──────────────────────────────
              FloatingIconCard(
                assetPath: AppAssets.forgotPassword,
                bottom: _iconBottom(step),
              ),
            ],
          );
        }),
      ),
    );
  }
}
