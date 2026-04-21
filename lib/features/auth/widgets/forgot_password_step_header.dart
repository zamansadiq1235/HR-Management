import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ForgotPasswordStepHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const ForgotPasswordStepHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Drag handle
        Container(
          width: 36.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),

        SizedBox(height: 22.h),

        /// Title
        Text(
          title,
          style: AppTextStyles.h3.copyWith(
            color: AppColors.textPrimary,
            fontSize: isTablet ? 24.sp : 20.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 8.h),

        /// Subtitle
        Text(
          subtitle,
          style: AppTextStyles.bodyText2.copyWith(
            color: AppColors.textSecondary,
            fontSize: isTablet ? 14.sp : 12.5.sp,
            height: 1.65,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
