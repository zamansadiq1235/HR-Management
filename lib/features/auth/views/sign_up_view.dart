import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hrmanagement/core/widgets/custom_textfield.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_phonefield.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/auth_view_model.dart';

class SignUpView extends GetView<AuthViewModel> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h)
              .copyWith(
                bottom: keyboardHeight + 24.h, // Add keyboard height + padding
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withAlpha((0.2 * 255).round()),
                        blurRadius: 10,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage(AppAssets.signupLogo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  'Work Mate',
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Register Using Your Credentials',
                  style: AppTextStyles.bodyText2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 28.h),
              Form(
                key: _signUpFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    CustomTextfield(
                      label: 'Email',
                      hintText: 'Enter Your Email',
                      isPassword: false,
                      obscureText: false,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppAssets.emailicon,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      controller: controller.signUpEmailController,
                      validator: controller.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),
                    CustomPhonefield(),
                    SizedBox(height: 16.h),
                    CustomTextfield(
                      label: 'Company ID',
                      hintText: 'Enter Company ID',
                      isPassword: false,
                      obscureText: false,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppAssets.useroctagon,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      controller: controller.signUpCompanyIdController,
                      validator: controller.validateCompanyId,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 16.h),
                    Obx(() {
                      return CustomTextfield(
                        label: 'Password',
                        hintText: 'My Password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            AppAssets.passwordicon,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        controller: controller.signUpPasswordController,
                        validator: controller.validatePassword,
                        keyboardType: TextInputType.text,
                        obscureText: !controller.passwordVisible.value,
                        isPassword: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.passwordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.primary,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      );
                    }),
                    SizedBox(height: 16.h),
                    Obx(() {
                      return CustomTextfield(
                        label: 'Confirm Password',
                        hintText: 'Confirm My Password',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            AppAssets.passwordicon,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        controller: controller.signUpConfirmPasswordController,
                        validator: controller.validateConfirmPassword,
                        keyboardType: TextInputType.text,
                        obscureText: !controller.passwordVisible.value,
                        isPassword: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.passwordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.primary,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      );
                    }),
                    SizedBox(height: 18.h),
                    Obx(() {
                      return Row(
                        children: [
                          Checkbox(
                            value: controller.acceptTerms.value,
                            onChanged: (_) => controller.toggleAcceptTerms(),
                            activeColor: AppColors.primary,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'I agree with ',
                                style: AppTextStyles.bodyText2.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'terms & conditions',
                                    style: AppTextStyles.bodyText2.copyWith(
                                      color: AppColors.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final result = await Get.toNamed(
                                          AppRoutes.terms,
                                        );
                                        if (result == true) {
                                          controller.acceptTerms.value = true;
                                        }
                                      },
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: AppTextStyles.bodyText2.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'privacy policy',
                                    style: AppTextStyles.bodyText2.copyWith(
                                      color: AppColors.primary,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // final result = await
                                        Get.toNamed(AppRoutes.terms);
                                        // if (result == true) {
                                        //   controller.acceptTerms.value = true;
                                        // }
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: 'Sign Up',
                      onPressed: () {
                        final isValid =
                            _signUpFormKey.currentState?.validate() ?? false;
                        if (isValid) {
                          Get.toNamed(AppRoutes.emailVerification);
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                    Center(
                      child: GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signIn),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: AppTextStyles.bodyText2.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign in here',
                                style: AppTextStyles.bodyText2.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
