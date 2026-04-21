// ─── lib/features/expense/views/widgets/expense_stat_box.dart

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ExpenseStatBox extends StatelessWidget {
  final String label;
  final Color dotColor;
  final String value; // pre-formatted e.g. "\$1010"

  const ExpenseStatBox({
    super.key,
    required this.label,
    required this.dotColor,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8FB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEF5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: AppColors.textHint),
              ),
            ],
          ),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
