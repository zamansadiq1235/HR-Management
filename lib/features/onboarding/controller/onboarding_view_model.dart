import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmanagement/core/constants/app_assets.dart';
import '../../../data/models/onboarding_info.dart';
import '../../../core/routes/app_routes.dart';

class OnboardingViewModel extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo(
      imageAsset: AppAssets.onboarding2,
      imageAsset1: AppAssets.onboarding1,
      title: 'Welcome to Workmate!',
      description:
          'Make Smart Decisions! Set clear timelines for projects and celebrate your achievements!',
    ),
    OnboardingInfo(
      imageAsset: AppAssets.onboarding5,
      imageAsset1: AppAssets.onboarding3,
      title: 'Manage Stress Effectively',
      description:
          'Stay Balanced! Track your workload and maintain a healthy stress level with ease.',
    ),
    OnboardingInfo(
      imageAsset: AppAssets.onboarding4,
      imageAsset1: AppAssets.onboarding1,
      title: 'Plan for Success',
      description:
          'Your Journey Starts Here! Earn achievement badges as you conquer your tasks. Let’s get started!',
    ),
    OnboardingInfo(
      imageAsset: AppAssets.onboarding1,
      imageAsset1: AppAssets.onboarding5,
      title: 'Navigate Your Work Journey\nEfficient & Easy',
      description:
          'Increase your work management & career development radically',
    ),
  ];

  void forwardAction() {
    if (isLastPage) {
      Get.offNamed(
        AppRoutes.home,
      ); // Assuming Home is the next route after login/signup
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void skipAction() {
    pageController.animateToPage(
      onboardingPages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void navigateToSignIn() {
    Get.offNamed(AppRoutes.signIn);
  }

  void navigateToSignUp() {
    Get.offNamed(AppRoutes.signUp);
  }
}
