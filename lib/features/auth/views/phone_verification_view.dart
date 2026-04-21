// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/auth_view_model.dart';

class PhoneVerificationView extends GetView<AuthViewModel> {
  const PhoneVerificationView({super.key});

  Widget _buildOtpField(int index) {
    final controller = Get.find<AuthViewModel>();

    return RawKeyboardListener(
      focusNode: FocusNode(),

      onKey: (event) {
        if (event.logicalKey == LogicalKeyboardKey.backspace) {
          if (controller.otpControllers[index].text.isEmpty && index > 0) {
            controller.focusNodes[index - 1].requestFocus();
          }
        }
      },

      child: SizedBox(
        width: 48.w,
        height: 58.h,
        child: TextFormField(
          controller: controller.otpControllers[index],
          focusNode: controller.focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,

          onChanged: (value) {
            /// Paste support
            if (value.length > 1) {
              controller.handlePaste(value);
              return;
            }

            /// Forward
            if (value.isNotEmpty && index < 5) {
              controller.focusNodes[index + 1].requestFocus();
            }

            controller.updateOtp();
          },

          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(1),
            counterText: '',
            counterStyle: AppTextStyles.bodyText2,
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardOpen = keyboardHeight > 0;

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
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              //top: isKeyboardOpen ? 95.h : 350.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 25.h),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      SizedBox(height: 25.h),
                      Text(
                        'Sign In Phone Number',
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'Sign in code has been sent to ${controller.phoneController.text}, check your inbox to continue the sign in process.',
                        style: AppTextStyles.bodyText2.copyWith(
                          color: AppColors.textPrimary.withAlpha(
                            (0.9 * 255).round(),
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          6,
                          (index) => _buildOtpField(index),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Haven’t received the sign in code? ',
                            style: AppTextStyles.bodyText2.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.snackbar(
                                'Resend',
                                'A new code has been requested',
                              );
                            },
                            child: Text(
                              'Resend it.',
                              style: AppTextStyles.bodyText2.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      CustomButton(
                        text: 'Submit',
                        onPressed: controller.submitPhoneVerification,
                      ),
                      SizedBox(height: 25.h),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          'Sign in with different method Here.',
                          style: AppTextStyles.bodyText2.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              // top: isKeyboardOpen ? 40.h : 305.h,
              left: 0,
              right: 0,
              bottom: 360.h,
              child: Center(
                child: Container(
                  width: 84.w,
                  height: 84.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.phone, size: 34, color: AppColors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
