// ─── lib/features/profile/screens/profile_screen.dart ───────

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/profile_controller.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});

  final ProfileController _c = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
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
                const SizedBox(height: 16),
                Obx(
                  () => _ProfileAvatar(
                    avatarPath:
                        _c.avatarPath.value ?? _c.profile.value.avatarPath,
                  ),
                ),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    child: Column(
                      children: [
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
                              const SizedBox(height: 4),
                              Text(
                                _c.profile.value.position,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                icon: Icons.verified_rounded,
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

//  Profile avatar ───────────────────────────────────────────
class _ProfileAvatar extends StatelessWidget {
  final String? avatarPath;
  const _ProfileAvatar({this.avatarPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEBFF),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: avatarPath != null
            ? Image.asset(
                avatarPath!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const _AvatarPlaceholder(),
              )
            : const _AvatarPlaceholder(),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEEBFF),
      child: Image.asset('assets/images/Ellipse2.png', fit: BoxFit.contain),
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
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.textHint,
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
        color: Colors.white,
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
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.primary, size: 16),
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Color(0xFFF0F0F5),
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
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
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
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            indent: 16,
            endIndent: 16,
            color: Color(0xFFF0F0F5),
          ),
      ],
    );
  }
}
