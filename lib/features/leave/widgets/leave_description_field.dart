// ─── lib/views/widgets/leave_description_field.dart ────────

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final String hint;

  const DescriptionField({
    super.key,
    required this.controller,
    this.maxLines = 5, required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 13.5,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
          hintText: hint,
           
          hintStyle:
              TextStyle(color: AppColors.textHint, fontSize: 13.5),
        ),
      ),
    );
  }
}