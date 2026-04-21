// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrmanagement/core/constants/app_colors.dart';
import 'package:hrmanagement/features/auth/controller/auth_view_model.dart';

class ForgotPasswordWidgets {
  static Widget _buildOtpField(int index) {
    final controller = Get.find<AuthViewModel>();
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace) {
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
            if (value.length > 1) {
              controller.handlePaste(value);
              return;
            }
            if (value.isNotEmpty &&
                index < controller.otpControllers.length - 1) {
              controller.focusNodes[index + 1].requestFocus();
            }
            controller.updateOtp();
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(1),
            counterText: '',
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }

  

}