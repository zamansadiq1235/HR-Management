// ─── lib/features/profile/screens/change_password_screen.dart

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/profile_controller.dart';
import '../widgets/bottom_btn.dart';
import '../widgets/profile_appBar.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CustomAppBar(title: 'Change Password'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change Password Form',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Fill information to change your password',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),

              _PasswordLabel('Current Password'),
              const SizedBox(height: 8),
              Obx(
                () => _PasswordField(
                  controller: c.currentPasswordCtrl,
                  hint: 'My Password',
                  obscure: c.showCurrentPw.value,
                  onToggle: () => c.showCurrentPw.toggle(),
                ),
              ),
              const SizedBox(height: 16),

              _PasswordLabel('New Password'),
              const SizedBox(height: 8),
              Obx(
                () => _PasswordField(
                  controller: c.newPasswordCtrl,
                  hint: 'My Password',
                  obscure: c.showNewPw.value,
                  onToggle: () => c.showNewPw.toggle(),
                ),
              ),
              const SizedBox(height: 16),

              _PasswordLabel('Confirm New Password'),
              const SizedBox(height: 8),
              Obx(
                () => _PasswordField(
                  controller: c.confirmPasswordCtrl,
                  hint: 'My Password',
                  obscure: c.showConfirmPw.value,
                  onToggle: () => c.showConfirmPw.toggle(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButtonWrapper(
        label: 'Update Password',
        onTap: () => c.showUpdatePasswordConfirm(context),
      ),
    );
  }
}

class _PasswordLabel extends StatelessWidget {
  final String text;
  const _PasswordLabel(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 12.5,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
  );
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE8E8F0), width: 1.2),
    ),
    child: Row(
      children: [
        // Lock icon tile
        Padding(
          padding: const EdgeInsets.all(1),
          child: SvgPicture.asset(
            AppAssets.passwordicon,
            width: 25,
            height: 25,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            obscureText: !obscure,
            style: const TextStyle(
              fontSize: 13.5,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.5,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onToggle,
          child: Icon(
            obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: AppColors.primary,
            size: 22,
          ),
        ),
      ],
    ),
  );
}
