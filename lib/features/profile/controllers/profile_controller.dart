// ─── lib/features/profile/controllers/profile_controller.dart

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmanagement/core/routes/app_routes.dart';
import 'package:hrmanagement/core/widgets/custom_button.dart';
import 'package:hrmanagement/features/profile/views/profile_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/services/storage_services.dart';
import '../models/profile_model.dart';
import '../views/change_password_screen.dart';
import '../views/office_assets.dart';
import '../views/payroll_screen.dart';
import '../views/personal_data.dart';

class ProfileController extends GetxController {
  final storage = StorageService();
  //  Profile state
  final profile = const ProfileModel().obs;

  //  Personal data form fields
  late final TextEditingController firstNameCtrl;
  late final TextEditingController lastNameCtrl;
  late final TextEditingController fullAddressCtrl;
  final selectedDob = '10 December 1997'.obs;
  final selectedPosition = 'Junior Full Stack Developer'.obs;
  final selectedCountry = 'Indonesia'.obs;
  final selectedState = 'DKI Jakarta'.obs;
  final selectedCity = 'Jakarta Selatan'.obs;
  final avatarPath = RxnString();

  //  Password form fields
  late final TextEditingController currentPasswordCtrl;
  late final TextEditingController newPasswordCtrl;
  late final TextEditingController confirmPasswordCtrl;
  final showCurrentPw = false.obs;
  final showNewPw = false.obs;
  final showConfirmPw = false.obs;

  //  OTP fields
  final otpValues = List.generate(6, (_) => '0'.obs);

  //  Options
  final positionOptions = [
    'Junior Full Stack Developer',
    'Senior Full Stack Developer',
    'Mid Full Stack Developer',
    'UI/UX Designer',
    'Project Manager',
  ];

  final countryOptions = ['Indonesia', 'Singapore', 'Malaysia', 'USA'];
  final stateOptions = ['DKI Jakarta', 'Jawa Barat', 'Jawa Timur', 'Bali'];
  final cityOptions = [
    'Jakarta Selatan',
    'Jakarta Pusat',
    'Jakarta Utara',
    'Bandung',
  ];

  @override
  void onInit() {
    super.onInit();
    firstNameCtrl = TextEditingController(text: profile.value.firstName);
    lastNameCtrl = TextEditingController(text: profile.value.lastName);
    fullAddressCtrl = TextEditingController(text: profile.value.fullAddress);
    currentPasswordCtrl = TextEditingController();
    newPasswordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
  }

  @override
  void onClose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    fullAddressCtrl.dispose();
    currentPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }

  //  Avatar pick (simulated) ──────────────────────────────
  void pickAvatar() {
    // In real app: use image_picker
    avatarPath.value = 'assets/images/avatar.png';
  }

  //  Personal data update ─────────────────────────────────
  void showUpdateProfileConfirm(BuildContext context) {
    _showSheet(
      context: context,
      title: 'Update Profile',
      body:
          'Are you sure you want to update your profile? This will help us improve your experience and provide personalized features.',
      icon: Icons.person_rounded,
      primaryLabel: 'Yes, Update Profile',
      secondaryLabel: 'No, Let me check',
      onPrimary: () {
        Get.back();
        _doUpdateProfile(context);
      },
      onSecondary: () => Navigator.pop(context),
    );
  }

  void _doUpdateProfile(BuildContext context) {
    profile.value = profile.value.copyWith(
      firstName: firstNameCtrl.text,
      lastName: lastNameCtrl.text,
      position: selectedPosition.value,
      country: selectedCountry.value,
      state: selectedState.value,
      city: selectedCity.value,
      fullAddress: fullAddressCtrl.text,
      dateOfBirth: selectedDob.value,
      avatarPath: avatarPath.value,
    );
    _showSheet(
      context: context,
      title: 'Profile Updated!',
      body:
          "Your profile has been successfully updated. We're excited to see you take this step!",
      icon: Icons.person_rounded,
      primaryLabel: 'View My Profile',
      showSecondary: false,
      onPrimary: () {
        Get.back();
      },
    );
  }

  //  Password update ──────────────────────────────────────
  void showUpdatePasswordConfirm(BuildContext context) {
    _showSheet(
      context: context,
      title: 'Update Password',
      body:
          'Are you sure you want to update your password? To ensure your account safety we will send verification code to your email',
      icon: Icons.bolt_rounded,
      primaryLabel: 'Yes, Update Password',
      secondaryLabel: 'No, Let me check',
      onPrimary: () {
        Get.back();
        _showOtpSheet(context);
      },
      onSecondary: () => Get.back(),
    );
  }

  void _showOtpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _OtpSheet(controller: this),
    );
  }

  void submitOtp(BuildContext context) {
    Get.back(); // close otp sheet
    _showSheet(
      context: Get.context!,
      title: 'Password Updated!',
      body:
          'Congratulations! you have been updated your password successfully! you can now access your account with your new password',
      icon: Icons.bolt_rounded,
      primaryLabel: 'Yes, Update Password',
      showSecondary: false,
      onPrimary: () => Get.to(MyProfileScreen()),
    );
  }

  //  Navigation
  void goToPersonalData() => Get.to(() => const PersonalDataScreen());
  void goToOfficeAssets() => Get.to(() => const OfficeAssetsScreen());
  void goToPayroll() => Get.to(() => const PayrollScreen());
  void goToChangePassword() => Get.to(() => const ChangePasswordScreen());
  void goToVersioning() => Get.snackbar(
    'Versioning',
    'App Version 1.0.0',
    snackPosition: SnackPosition.BOTTOM,
  );
  void goToFaqHelp() => Get.snackbar(
    'FAQ & Help',
    'Coming soon',
    snackPosition: SnackPosition.BOTTOM,
  );
  void logout() {
    Get.defaultDialog(
      titlePadding: EdgeInsets.only(top: 12),
      contentPadding: EdgeInsets.all(5),
      title: "Logout",
      middleText: "Are you sure you want to log out?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primary,
      onConfirm: () {
        // Execute original logout logic
        storage.logout();
        Get.offAllNamed(AppRoutes.onboarding);
      },
    );
  }

  //  Shared bottom sheet builder
  void _showSheet({
    required BuildContext context,
    required String title,
    required String body,
    required IconData icon,
    required String primaryLabel,
    String secondaryLabel = 'No, Let me check',
    required VoidCallback onPrimary,
    VoidCallback? onSecondary,
    bool showSecondary = true,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _ProfileSheet(
        title: title,
        body: body,
        icon: icon,
        primaryLabel: primaryLabel,
        secondaryLabel: secondaryLabel,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        showSecondary: showSecondary,
      ),
    );
  }
}

//  Shared bottom sheet

class _ProfileSheet extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback onPrimary;
  final VoidCallback? onSecondary;
  final bool showSecondary;

  const _ProfileSheet({
    required this.title,
    required this.body,
    required this.icon,
    required this.primaryLabel,
    this.secondaryLabel = 'No, Let me check',
    required this.onPrimary,
    this.onSecondary,
    this.showSecondary = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 28),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                body,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: CustomButton(text: primaryLabel, onPressed: onPrimary),
              ),
              if (showSecondary) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: onSecondary,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1.4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text(secondaryLabel),
                  ),
                ),
              ],
            ],
          ),
        ),
        Positioned(
          top: -38,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 36),
          ),
        ),
      ],
    );
  }
}

//  OTP Sheet
class _OtpSheet extends StatefulWidget {
  final ProfileController controller;
  const _OtpSheet({required this.controller});

  @override
  State<_OtpSheet> createState() => _OtpSheetState();
}

class _OtpSheetState extends State<_OtpSheet> {
  final _controllers = List.generate(
    6,
    (_) => TextEditingController(text: '0'),
  );
  final _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: EdgeInsets.fromLTRB(
            24,
            0,
            24,
            MediaQuery.of(context).viewInsets.bottom + 36,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 28),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 13.5,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: 'A reset code has been sent to '),
                    TextSpan(
                      text: 'Tonald@work.com',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text:
                          ', check your email to continue the password reset process.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // OTP input row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) {
                  return SizedBox(
                    width: 48,
                    height: 56,
                    child: TextField(
                      controller: _controllers[i],
                      focusNode: _focusNodes[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFE8E8F0),
                            width: 1.2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty && i < 5) {
                          _focusNodes[i + 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    "Haven't received the verification code? ",
                    style: TextStyle(
                      fontSize: 12.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Resend it.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: CustomButton(
                  text: 'Submit',
                  onPressed: () => widget.controller.submitOtp(context),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -38,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.shield_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
      ],
    );
  }
}
