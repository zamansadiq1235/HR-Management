// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/onboarding_view_model.dart';

class OnboardingView extends GetView<OnboardingViewModel> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingViewModel());
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.15, 0.5],
            colors: [
              AppColors.primary,
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.selectedPageIndex.call,
                  itemCount: controller.onboardingPages.length,
                  itemBuilder: (_, index) {
                    final page = controller.onboardingPages[index];

                    /// layout config per page
                    final layouts = [
                      {
                        "bgW": 320.w,
                        "bgH": 425.h,
                        "bgTop": 35.h,
                        "bgLeft": 10.w,

                        "fgW": 250.w,
                        "fgH": 230.h,
                        "fgTop": 145.h,
                        "fgLeft": 90.w,
                      },
                      {
                        "bgW": 330.w,
                        "bgH": 420.h,
                        "bgTop": 40.h,
                        "bgLeft": 10.w,

                        "fgW": 330.w,
                        "fgH": 420.h,
                        "fgTop": 150.h,
                        "fgLeft": 25.w,
                      },
                      {
                        "bgW": 340.w,
                        "bgH": 190.h,
                        "bgTop": 35.h,
                        "bgLeft": 15.w,

                        "fgW": 300.w,
                        "fgH": 235.h,
                        "fgTop": 165.h,
                        "fgLeft": 35.w,
                      },
                      {
                        "bgW": 260.w,
                        "bgH": 280.h,
                        "bgTop": 30.h,
                        "bgLeft": 40.w,

                        "fgW": 320.w,
                        "fgH": 480.h,
                        "fgTop": 135.h,
                        "fgLeft": 30.w,
                      },
                    ];

                    final layout = layouts[index];

                    return Stack(
                      children: [
                        /// BACK IMAGE
                        Positioned(
                          top: layout["bgTop"] as double,
                          left: layout["bgLeft"] as double,
                          child: Image.asset(
                            page.imageAsset!,
                            width: layout["bgW"] as double,
                            height: layout["bgH"] as double,
                            fit: BoxFit.contain,
                          ),
                        ),

                        /// FRONT IMAGE
                        Positioned(
                          top: layout["fgTop"] as double,
                          left: layout["fgLeft"] as double,
                          child: Image.asset(
                            page.imageAsset1!,
                            width: layout["fgW"] as double,
                            height: layout["fgH"] as double,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Expanded(
                flex: 4,
                child: Obx(() {
                  final pageInfo = controller
                      .onboardingPages[controller.selectedPageIndex.value];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          pageInfo.title,
                          style: AppTextStyles.h3.copyWith(
                            fontSize: controller.selectedPageIndex.value == 2
                                ? 21
                                : 20, // slight shrink for final title
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pageInfo.description,
                          style: AppTextStyles.bodyText2.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 25.h),
                        controller.selectedPageIndex.value ==
                                controller.onboardingPages.length - 1
                            ? Container(height: 1)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  controller.onboardingPages.length - 1,
                                  (index) => Obx(() {
                                    return AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      width: 20,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color:
                                            controller
                                                    .selectedPageIndex
                                                    .value ==
                                                index
                                            ? AppColors.primary
                                            : AppColors.primaryLight
                                                  .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                        Spacer(),
                        // SizedBox(height: 20.h),
                        if (controller.isLastPage) ...[
                          CustomButton(
                            text: 'Sign In',
                            onPressed: controller.navigateToSignIn,
                          ),
                          SizedBox(height: 15.h),
                          CustomButton(
                            text: 'Sign Up',
                            onPressed: controller.navigateToSignUp,
                            isOutlined: true,
                          ),
                        ] else ...[
                          CustomButton(
                            text: 'Next',
                            onPressed: controller.forwardAction,
                          ),
                          SizedBox(height: 13.h),
                          CustomButton(
                            text: 'Skip',
                            onPressed: controller.skipAction,
                            isOutlined: true,
                          ),
                        ],
                        SizedBox(height: 10.h),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
