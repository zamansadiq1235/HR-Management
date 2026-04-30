// ─── lib/features/profile/screens/personal_data_screen.dart ─

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmanagement/core/widgets/custom_button.dart';
import 'package:hrmanagement/features/leave/widgets/leave_description_field.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../controllers/profile_controller.dart';
import '../widgets/form_card.dart';

class PersonalDataScreen extends StatelessWidget {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        child: Column(
          children: [
            // ── Personal info card ───────────────
            FormCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Personal Data',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Details about my personal data',
                    style: TextStyle(fontSize: 12, color: AppColors.textHint),
                  ),
                  const SizedBox(height: 20),

                  // Avatar picker
                  Center(
                    child: GestureDetector(
                      onTap: () => _showPickerMenu(context, c),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Obx(() {
                            final path =
                                (c.avatarPath.value?.isNotEmpty ?? false)
                                ? c.avatarPath.value
                                : c.profile.value.avatarPath;

                            return Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEBFF),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(17),
                                child: (path != null && path.isNotEmpty)
                                    ? _buildImage(
                                        path,
                                      ) // Handles both File and Asset
                                    : Image.asset(
                                        'assets/images/Ellipse2.png',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            );
                          }),
                          Positioned(
                            top: -10,
                            right: -10,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.refresh_rounded,
                                color: Colors.white,
                                size: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Upload Photo',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Format should be in .jpeg .png atleast\n800×800px and less than 5MB',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // First Name
                  CustomTextfield(
                    controller: c.firstNameCtrl,
                    label: 'First Name',
                    hintText: '',
                    isPassword: false,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextfield(
                    controller: c.lastNameCtrl,
                    label: 'Last Name',
                    hintText: '',
                    isPassword: false,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Date of Birth
                  FieldLabel('Date of Birth'),
                  const SizedBox(height: 8),
                  Obx(
                    () => DropdownTile(
                      icon: Icons.calendar_month_rounded,
                      value: c.selectedDob.value,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(1997, 12, 10),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                          builder: (ctx, child) => Theme(
                            data: Theme.of(ctx).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: AppColors.primary,
                              ),
                            ),
                            child: child!,
                          ),
                        );
                        if (picked != null) {
                          const months = [
                            '',
                            'January',
                            'February',
                            'March',
                            'April',
                            'May',
                            'June',
                            'July',
                            'August',
                            'September',
                            'October',
                            'November',
                            'December',
                          ];
                          c.selectedDob.value =
                              '${picked.day} ${months[picked.month]} ${picked.year}';
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Position
                  FieldLabel('Position'),
                  const SizedBox(height: 8),
                  Obx(
                    () => SelectionTile(
                      icon: Icons.work_outline_rounded,
                      value: c.selectedPosition.value,
                      options: c.positionOptions,
                      onSelect: (v) => c.selectedPosition.value = v,
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Address card
            FormCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Address',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Your current domicile',
                    style: TextStyle(fontSize: 12, color: AppColors.textHint),
                  ),
                  const SizedBox(height: 20),

                  // Country
                  FieldLabel('Country'),
                  const SizedBox(height: 8),
                  Obx(
                    () => SelectionTile(
                      icon: Icons.location_on_outlined,
                      value: c.selectedCountry.value,
                      options: c.countryOptions,
                      onSelect: (v) => c.selectedCountry.value = v,
                      context: context,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // State
                  FieldLabel('State'),
                  const SizedBox(height: 8),
                  Obx(
                    () => SelectionTile(
                      icon: Icons.location_on_outlined,
                      value: c.selectedState.value,
                      options: c.stateOptions,
                      onSelect: (v) => c.selectedState.value = v,
                      context: context,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // City
                  FieldLabel('City'),
                  const SizedBox(height: 8),
                  Obx(
                    () => SelectionTile(
                      icon: Icons.location_on_outlined,
                      value: c.selectedCity.value,
                      options: c.cityOptions,
                      onSelect: (v) => c.selectedCity.value = v,
                      context: context,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Full Address
                  FieldLabel('Full Address'),
                  const SizedBox(height: 8),
                  DescriptionField(controller: c.fullAddressCtrl, hint: ''),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: CustomButton(
            text: 'Update',
            onPressed: () => c.showUpdateProfileConfirm(context),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.primary,
            size: 25,
          ),
        ),
      ),
      title: const Text(
        'Personal Data',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  void _showPickerMenu(BuildContext context, ProfileController c) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Gallery'),
              onTap: () {
                c.pickAvatar(ImageSource.gallery);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                c.pickAvatar(ImageSource.camera);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String path) {
    // If the path starts with 'assets/', treat it as an asset
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.person),
      );
    }

    // Otherwise, treat it as a file on the device
    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.person_rounded, color: AppColors.primary, size: 46),
    );
  }
}
