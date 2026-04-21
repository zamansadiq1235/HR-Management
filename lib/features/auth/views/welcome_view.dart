import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      /// 🔒 Safe area for all devices (notch, status bar)
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 1.sw,
            height: 1.sh,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE9E6FF), AppColors.background],
              ),
            ),
          ),

          /// 📦 Bottom Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20.r,
                    offset: Offset(0, -5.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16.h),

                  /// 📝 Title
                  Text(
                    'Welcome To Work Mate!',
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 12.h),

                  /// 📄 Description
                  Text(
                    'To enhance your user experience, please set up your profile first. '
                    'This will help us tailor the app to your needs and ensure you get the most out of our features!',
                    style: AppTextStyles.bodyText2.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 13.sp,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 20.h),

                  /// 🔘 Primary Button
                  CustomButton(
                    text: 'Set Up My Profile',
                    onPressed: () {
                      Get.offNamed(AppRoutes.profile);
                    },
                  ),

                  SizedBox(height: 16.h),

                  /// 🔘 Secondary Button
                  CustomButton(
                    text: 'Explore The App First',
                    isOutlined: true,
                    onPressed: () {
                      Get.offNamed(AppRoutes.navBar);
                    },
                  ),

                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),

          /// 🔥 Center Floating Icon Card
          Positioned(
            bottom: 320.h,
            child: Container(
              width: 84.w,
              height: 84.w,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withAlpha((0.25 * 255).round()),
                    blurRadius: 20.r,
                    offset: Offset(0, 12.h),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.useroctagonfilled,
                  width: 40.w,
                  height: 40.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
