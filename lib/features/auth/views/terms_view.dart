import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Terms & Conditions and Privacy Policy',
                textAlign: TextAlign.center,

                style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textSecondary.withAlpha(
                        (0.12 * 255).round(),
                      ),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terms and Conditions:',
                          style: AppTextStyles.bodyText1.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          '''
Acceptance: By using the Re-Dup app, you agree to comply with all applicable terms and conditions.

Usage: This app is for personal use only and may not be used for commercial purposes without permission.

Account: You are responsible for the security of your account and all activities that occur within it.

Content: You must not upload content that violates copyright, privacy, or applicable laws.

Changes: We reserve the right to change the terms and conditions at any time and will notify you of these changes through the app or via email.

Privacy Policy:\nData Collection: We collect personal data such as name, email, and location to process transactions and improve our services.

Data Usage: Your data is used for internal purposes such as account management, usage analysis, and service improvement.

Security: We protect your data with appropriate security measures to prevent unauthorized access.

Data Sharing: We do not share your personal data with third parties without your consent, except as required by law.

Your Rights: You can access, update, or delete your personal data at any time through the app settings or by contacting support.''',
                          style: AppTextStyles.bodyText2.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                children: [
                  CustomButton(
                    text: 'I Agree',
                    onPressed: () {
                      Get.back(result: true);
                    },
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    text: 'Decline',
                    isOutlined: true,
                    onPressed: () {
                      Get.back(result: false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
