// ─── lib/features/profile/screens/personal_data_screen.dart ─

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmanagement/core/widgets/custom_button.dart';
import 'package:hrmanagement/features/leave/widgets/leave_description_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../controllers/profile_controller.dart';

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
            _FormCard(
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
                      onTap: c.pickAvatar,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Obx(
                            () => Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEBFF),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(17),
                                child:
                                    (c.avatarPath.value ??
                                            c.profile.value.avatarPath) !=
                                        null
                                    ? Image.asset(
                                        c.avatarPath.value ??
                                            c.profile.value.avatarPath!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, _, _) =>
                                            const Icon(
                                              Icons.person_rounded,
                                              color: AppColors.primary,
                                              size: 46,
                                            ),
                                      )
                                    : Image.asset(
                                        'assets/images/Ellipse2.png',
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
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
                  _FieldLabel('Date of Birth'),
                  const SizedBox(height: 8),
                  Obx(
                    () => _DropdownTile(
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
                  _FieldLabel('Position'),
                  const SizedBox(height: 8),
                  Obx(
                    () => _SelectionTile(
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
            _FormCard(
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
                  _FieldLabel('Country'),
                  const SizedBox(height: 8),
                  Obx(
                    () => _SelectionTile(
                      icon: Icons.location_on_outlined,
                      value: c.selectedCountry.value,
                      options: c.countryOptions,
                      onSelect: (v) => c.selectedCountry.value = v,
                      context: context,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // State
                  _FieldLabel('State'),
                  const SizedBox(height: 8),
                  Obx(
                    () => _SelectionTile(
                      icon: Icons.location_on_outlined,
                      value: c.selectedState.value,
                      options: c.stateOptions,
                      onSelect: (v) => c.selectedState.value = v,
                      context: context,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // City
                  _FieldLabel('City'),
                  const SizedBox(height: 8),
                  Obx(
                    () => _SelectionTile(
                      icon: Icons.location_on_outlined,
                      value: c.selectedCity.value,
                      options: c.cityOptions,
                      onSelect: (v) => c.selectedCity.value = v,
                      context: context,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Full Address
                  _FieldLabel('Full Address'),
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
          child: CustomButton(text: 'Update',
           onPressed: () => c.showUpdateProfileConfirm(context),)
       ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.primary,
            size: 22,
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
}

// ── Shared form widgets ──────────────────────────────────────

class _FormCard extends StatelessWidget {
  final Widget child;
  const _FormCard({required this.child});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
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
    child: child,
  );
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

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

class _DropdownTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final VoidCallback onTap;
  const _DropdownTile({
    required this.icon,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8F0), width: 1.2),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13.5,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textHint,
            size: 20,
          ),
        ],
      ),
    ),
  );
}

class _SelectionTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final List<String> options;
  final void Function(String) onSelect;
  final BuildContext context;

  const _SelectionTile({
    required this.icon,
    required this.value,
    required this.options,
    required this.onSelect,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) => GestureDetector(
    onTap: () => _showSheet(),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8F0), width: 1.2),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13.5,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textHint,
            size: 20,
          ),
        ],
      ),
    ),
  );

  void _showSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 16),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: ListView(
                shrinkWrap: true,
                children: options
                    .map(
                      (opt) => ListTile(
                        title: Text(opt),
                        trailing: opt == value
                            ? const Icon(
                                Icons.check_rounded,
                                color: AppColors.primary,
                              )
                            : null,
                        onTap: () {
                          onSelect(opt);
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
