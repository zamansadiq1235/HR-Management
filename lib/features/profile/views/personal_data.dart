// ─── lib/features/profile/screens/personal_data_screen.dart ─

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
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
                  const Text('My Personal Data',
                      style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      )),
                  const SizedBox(height: 2),
                  const Text('Details about my personal data',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textHint)),
                  const SizedBox(height: 20),

                  // Avatar picker
                  Center(
                    child: GestureDetector(
                      onTap: c.pickAvatar,
                      child: Stack(
                        children: [
                          Obx(() => Container(
                                width: 90, height: 90,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEEBFF),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(17),
                                  child: (c.avatarPath.value ??
                                              c.profile.value.avatarPath) !=
                                          null
                                      ? Image.asset(
                                          c.avatarPath.value ??
                                              c.profile.value.avatarPath!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(Icons.person_rounded,
                                                  color: AppColors.primary,
                                                  size: 46),
                                        )
                                      : const Icon(Icons.person_rounded,
                                          color: AppColors.primary, size: 46),
                                ),
                              )),
                          Positioned(
                            top: 0, right: 0,
                            child: Container(
                              width: 26, height: 26,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 2),
                              ),
                              child: const Icon(Icons.refresh_rounded,
                                  color: Colors.white, size: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text('Upload Photo',
                        style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        )),
                  ),
                  const Center(
                    child: Text(
                      'Format should be in .jpeg .png atleast\n800×800px and less than 5MB',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10.5, color: AppColors.textHint),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // First Name
                  _FieldLabel('First Name'),
                  const SizedBox(height: 8),
                  _TextField(
                    controller: c.firstNameCtrl,
                    icon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 16),

                  // Last Name
                  _FieldLabel('Last Name'),
                  const SizedBox(height: 8),
                  _TextField(
                    controller: c.lastNameCtrl,
                    icon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 16),

                  // Date of Birth
                  _FieldLabel('Date of Birth'),
                  const SizedBox(height: 8),
                  Obx(() => _DropdownTile(
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
                                    primary: AppColors.primary),
                              ),
                              child: child!,
                            ),
                          );
                          if (picked != null) {
                            const months = [
                              '', 'January', 'February', 'March',
                              'April', 'May', 'June', 'July', 'August',
                              'September', 'October', 'November', 'December'
                            ];
                            c.selectedDob.value =
                                '${picked.day} ${months[picked.month]} ${picked.year}';
                          }
                        },
                      )),
                  const SizedBox(height: 16),

                  // Position
                  _FieldLabel('Position'),
                  const SizedBox(height: 8),
                  Obx(() => _SelectionTile(
                        icon: Icons.work_outline_rounded,
                        value: c.selectedPosition.value,
                        options: c.positionOptions,
                        onSelect: (v) => c.selectedPosition.value = v,
                        context: context,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Address card ─────────────────────
            _FormCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Address',
                      style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      )),
                  const SizedBox(height: 2),
                  const Text('Your current domicile',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textHint)),
                  const SizedBox(height: 20),

                  // Country
                  _FieldLabel('Country'),
                  const SizedBox(height: 8),
                  Obx(() => _SelectionTile(
                        icon: Icons.shield_outlined,
                        value: c.selectedCountry.value,
                        options: c.countryOptions,
                        onSelect: (v) => c.selectedCountry.value = v,
                        context: context,
                      )),
                  const SizedBox(height: 16),

                  // State
                  _FieldLabel('State'),
                  const SizedBox(height: 8),
                  Obx(() => _SelectionTile(
                        icon: Icons.shield_outlined,
                        value: c.selectedState.value,
                        options: c.stateOptions,
                        onSelect: (v) => c.selectedState.value = v,
                        context: context,
                      )),
                  const SizedBox(height: 16),

                  // City
                  _FieldLabel('City'),
                  const SizedBox(height: 8),
                  Obx(() => _SelectionTile(
                        icon: Icons.shield_outlined,
                        value: c.selectedCity.value,
                        options: c.cityOptions,
                        onSelect: (v) => c.selectedCity.value = v,
                        context: context,
                      )),
                  const SizedBox(height: 16),

                  // Full Address
                  _FieldLabel('Full Address'),
                  const SizedBox(height: 8),
                  _TextAreaField(controller: c.fullAddressCtrl),
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
          width: double.infinity, height: 52,
          child: ElevatedButton(
            onPressed: () => c.showUpdateProfileConfirm(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
              textStyle: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
            child: const Text('Update'),
          ),
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
          child: const Icon(Icons.chevron_left_rounded,
              color: AppColors.primary, size: 22),
        ),
      ),
      title: const Text('Personal Data',
          style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          )),
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
              blurRadius: 14, offset: const Offset(0, 4),
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
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
        fontSize: 12.5, fontWeight: FontWeight.w500,
        color: AppColors.textHint,
      ));
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  const _TextField({required this.controller, required this.icon});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8E8F0), width: 1.2),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(
                    fontSize: 13.5, color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
}

class _TextAreaField extends StatelessWidget {
  final TextEditingController controller;
  const _TextAreaField({required this.controller});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8E8F0), width: 1.2),
        ),
        child: TextField(
          controller: controller,
          maxLines: 4,
          style: const TextStyle(
              fontSize: 13.5, color: AppColors.textPrimary),
          decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(14),
            hintText: 'Full Address',
            hintStyle:
                TextStyle(color: AppColors.textHint, fontSize: 13.5),
          ),
        ),
      );
}

class _DropdownTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final VoidCallback onTap;
  const _DropdownTile(
      {required this.icon, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8E8F0), width: 1.2),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(value,
                    style: const TextStyle(
                      fontSize: 13.5, color: AppColors.textPrimary,
                    )),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textHint, size: 20),
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
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE8E8F0), width: 1.2),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(value,
                    style: const TextStyle(
                      fontSize: 13.5, color: AppColors.textPrimary,
                    )),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textHint, size: 20),
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
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5),
              child: ListView(
                shrinkWrap: true,
                children: options
                    .map((opt) => ListTile(
                          title: Text(opt),
                          trailing: opt == value
                              ? const Icon(Icons.check_rounded,
                                  color: AppColors.primary)
                              : null,
                          onTap: () {
                            onSelect(opt);
                            Navigator.pop(context);
                          },
                        ))
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