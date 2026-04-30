import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_phonefield.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/auth_view_model.dart';

class SignInView extends GetView<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignInView({super.key});

  Widget _buildMethodButton({
    required String label,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 56.h),
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        foregroundColor: AppColors.primary,
      ),
      icon: icon,
      label: Text(
        label,
        style: AppTextStyles.button.copyWith(color: AppColors.primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const topRadius = Radius.circular(32);

    return Scaffold(
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
            Positioned(
              top: 160.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 24.w,
                  top: 20.h,
                  right: 24.w,
                  bottom: 0,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: topRadius,
                    topRight: topRadius,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Obx(() {
                    final selected = controller.signInMethod.value;
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Sign In',
                            style: AppTextStyles.h2.copyWith(
                              color: AppColors.bottomNavBg,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Sign in to my account',
                            style: AppTextStyles.bodyText2.copyWith(
                              color: AppColors.bottomNavBg.withAlpha(
                                (0.85 * 255).round(),
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          if (selected == SignInMethod.email) ...[
                            CustomTextfield(
                              label: 'Email',
                              hintText: 'My Email',
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

                              controller: controller.emailController,
                              validator: controller.validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              isPassword: false,
                              obscureText: false,
                            ),

                            SizedBox(height: 16.h),
                          ],
                          if (selected == SignInMethod.employeeId) ...[
                            CustomTextfield(
                              label: 'Employee ID',
                              hintText: 'My Employee ID',
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
                              controller: controller.employeeIdController,
                              validator: controller.validateEmployeeId,
                              keyboardType: TextInputType.text,
                              isPassword: false,
                              obscureText: false,
                            ),

                            SizedBox(height: 16.h),
                          ],
                          if (selected == SignInMethod.phone) ...[
                            CustomPhonefield(
                              label: 'Phone Number',
                              controller: controller.phoneController,
                            ),
                            SizedBox(height: 16.h),
                          ],
                          if (selected != SignInMethod.phone) ...[
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
                                controller: controller.passwordController,
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
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                ),
                              );
                            }),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Obx(() {
                                  return Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged: (_) =>
                                        controller.toggleRememberMe(),
                                    activeColor: AppColors.primary,
                                  );
                                }),
                                Expanded(
                                  child: Text(
                                    'Remember Me',
                                    style: AppTextStyles.bodyText2,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.forgotPassword);
                                  },
                                  child: Text(
                                    'Forgot Password',
                                    style: AppTextStyles.bodyText2.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          SizedBox(height: 16.h),
                          CustomButton(
                            text: 'Sign In',
                            onPressed: () {
                              final isValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (isValid) {
                                controller.submitSignIn();
                              }
                            },
                          ),
                          SizedBox(height: 25.h),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  height: 1,
                                  color: AppColors.border,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Text(
                                  'OR',
                                  style: AppTextStyles.bodyText2.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  height: 1,
                                  color: AppColors.border,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.h),
                          _buildMethodButton(
                            label:
                                controller.signInMethod.value ==
                                    SignInMethod.employeeId
                                ? 'Sign in With Email'
                                : 'Sign in With Employee ID',
                            icon:
                                controller.signInMethod.value ==
                                    SignInMethod.employeeId
                                ? SvgPicture.asset(
                                    AppAssets.smsfilled,
                                    width: 22,
                                    height: 22,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.primary,
                                      BlendMode.srcIn,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    AppAssets.useroctagonfilled,
                                    width: 22,
                                    height: 22,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                            onTap: () => controller.setSignInMethod(
                              controller.signInMethod.value ==
                                      SignInMethod.employeeId
                                  ? SignInMethod.email
                                  : SignInMethod.employeeId,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          _buildMethodButton(
                            label: 'Sign in With Phone',
                            icon: Icon(Icons.phone, color: AppColors.primary),
                            onTap: () =>
                                controller.setSignInMethod(SignInMethod.phone),
                          ),
                          SizedBox(height: 24.h),
                          Center(
                            child: GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.signUp),
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: AppTextStyles.bodyText2.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Sign Up Here',
                                      style: AppTextStyles.bodyText2.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25.h),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
