// ─── lib/features/profile/screens/office_assets_screen.dart ─

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../widgets/profile_appBar.dart';

class OfficeAssetsScreen extends StatelessWidget {
  const OfficeAssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CustomAppBar(title: 'Office Assets'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
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
                'Assets Information',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Your office assets information',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),

              // Asset image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/images/laptop.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    height: 200,
                    color: const Color(0xFFF0F0F5),
                    child: const Center(
                      child: Icon(
                        Icons.laptop_mac_rounded,
                        size: 84,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Fields (read-only display)
              _AssetField(
                label: 'Assets Name',
                value: 'Laptop Macbook Air M1 2020',
                icon: Icons.terminal_rounded,
              ),
              const SizedBox(height: 14),
              _AssetField(
                label: 'Brand',
                value: 'Apple',
                icon: Icons.business_rounded,
              ),
              const SizedBox(height: 14),
              _AssetField(
                label: 'Warranty Status',
                value: 'Off',
                icon: Icons.shield_outlined,
              ),
              const SizedBox(height: 14),
              _AssetField(
                label: 'Buying Date',
                value: '12 September 2020',
                icon: Icons.edit_calendar_rounded,
              ),
              const SizedBox(height: 14),
              _AssetDropdownField(
                label: 'Received On',
                value: '14 September 2020',
                icon: Icons.calendar_month_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssetField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _AssetField({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 12.5,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8E8F0), width: 1.2),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(width: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13.5,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _AssetDropdownField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _AssetDropdownField({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 12.5,
          color: AppColors.textHint,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 6),
      Container(
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
    ],
  );
}
