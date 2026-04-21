import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ResendCodeRow extends StatelessWidget {
  final VoidCallback onResendTap;

  const ResendCodeRow({
    super.key,
    required this.onResendTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Haven't received the verification code? ",
          style: AppTextStyles.bodyText2.copyWith(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: onResendTap,
          child: Text(
            'Resend it.',
            style: AppTextStyles.bodyText2.copyWith(
              color: AppColors.primary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
