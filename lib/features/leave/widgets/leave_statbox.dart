// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmanagement/core/constants/app_text_styles.dart';

import '../../../core/constants/app_colors.dart';

class LeaveStatBox extends StatelessWidget {
  final String label;
  final Color dotColor;
  final RxInt valueObs;

  const LeaveStatBox({
    required this.label,
    required this.dotColor,
    required this.valueObs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 11, 14, 11),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
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
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Obx(() => Text('${valueObs.value}', style: AppTextStyles.h3)),
        ],
      ),
    );
  }
}
