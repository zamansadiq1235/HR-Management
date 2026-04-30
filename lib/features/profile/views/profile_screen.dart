// ─── lib/features/profile/screens/profile_screen.dart ───────

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_avatar.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});

  final ProfileController _c = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          //  Purple header background ─────────
          Container(
            height: 200,
            width: double.infinity,
            color: AppColors.primary,
          ),

          //  Content
          SafeArea(
            child: Column(
              children: [
                // App bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.cardBg,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            color: AppColors.primary,
                            size: 22,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'My Profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 36),
                    ],
                  ),
                ),

                // Avatar
                const SizedBox(height: 60),
                Obx(
                  () => ProfileAvatar(
                    avatarPath: _c.avatarPath.value?.isNotEmpty == true
                        ? _c.avatarPath.value
                        : _c.profile.value.avatarPath,
                  ),
                ),
                const SizedBox(height: 14),
                // Name + role
                Obx(
                  () => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _c.profile.value.fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.verified_rounded,
                            color: AppColors.primary,
                            size: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _c.profile.value.position,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),

                        // CONTACT section
                        _SectionLabel('CONTACT'),
                        const SizedBox(height: 10),
                        Obx(
                          () => _MenuCard(
                            items: [
                              _InfoRow(
                                icon: Icons.email_rounded,
                                text: _c.profile.value.email,
                                showDivider: true,
                              ),
                              _InfoRow(
                                icon: Icons.location_on,
                                text: _c.profile.value.address,
                                showDivider: false,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ACCOUNT section
                        _SectionLabel('ACCOUNT'),
                        const SizedBox(height: 10),
                        _MenuCard(
                          items: [
                            _MenuRow(
                              icon: Icons.person_rounded,
                              label: 'Personal Data',
                              onTap: _c.goToPersonalData,
                              showDivider: true,
                            ),
                            _MenuRow(
                              icon: Icons.folder_rounded,
                              label: 'Office Assets',
                              onTap: _c.goToOfficeAssets,
                              showDivider: true,
                            ),
                            _MenuRow(
                              icon: Icons.radio_button_checked_rounded,
                              label: 'Payroll & Tax',
                              onTap: _c.goToPayroll,
                              showDivider: false,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // SETTINGS section
                        _SectionLabel('SETTINGS'),
                        const SizedBox(height: 10),
                        _MenuCard(
                          items: [
                            _MenuRow(
                              icon: Icons.settings_rounded,
                              label: 'Change Password',
                              onTap: _c.goToChangePassword,
                              showDivider: true,
                            ),
                            _MenuRow(
                              icon: Icons.update_rounded,
                              label: 'Versioning',
                              onTap: _c.goToVersioning,
                              showDivider: true,
                            ),
                            _MenuRow(
                              icon: Icons.help_outline_rounded,
                              label: 'FAQ and Help',
                              onTap: _c.goToFaqHelp,
                              showDivider: true,
                            ),
                            _MenuRow(
                              icon: Icons.logout_rounded,
                              iconColor: Colors.red,
                              label: 'Logout',
                              onTap: _c.logout,
                              showDivider: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//  Section label ────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

//  Menu card container ──────────────────────────────────────
class _MenuCard extends StatelessWidget {
  final List<Widget> items;
  const _MenuCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backsurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }
}

//  Info row (contact) ───────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool showDivider;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 22),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//  Menu row (tappable) ──────────────────────────────────────
class _MenuRow extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;

  const _MenuRow({
    required this.icon,
    this.iconColor,
    required this.label,
    required this.onTap,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? AppColors.primary;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textHint,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
