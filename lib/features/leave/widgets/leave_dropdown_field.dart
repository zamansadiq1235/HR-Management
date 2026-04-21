// ─── lib/views/widgets/leave_dropdown_field.dart ───────────

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// A styled tappable field that opens a [SelectionBottomSheet].
/// Pass [onTap] which triggers the sheet; display [value] or [hintText].
class LeaveDropdownField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final String? value;
  final VoidCallback onTap;

  const LeaveDropdownField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 1.2),
        ),
        child: Row(
          children: [
            // Icon tile
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primary, size: 17),
            ),
            const SizedBox(width: 12),
            // Label
            Expanded(
              child: Text(
                hasValue ? value! : hintText,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight:
                      hasValue ? FontWeight.w500 : FontWeight.w400,
                  color: hasValue
                      ? AppColors.textPrimary
                      : AppColors.textHint,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Chevron
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
}