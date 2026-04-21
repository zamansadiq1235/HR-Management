// ─── lib/features/expense/views/widgets/expense_empty_state.dart

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../models/expense_model.dart';

class ExpenseEmptyState extends StatelessWidget {
  final ExpenseStatus status;

  const ExpenseEmptyState({super.key, required this.status});

  String get _title {
    switch (status) {
      case ExpenseStatus.review:
        return 'No Expense Submitted';
      case ExpenseStatus.approved:
        return 'No Expense Approved';
      case ExpenseStatus.rejected:
        return 'No Expense Rejected';
    }
  }

  String get _subtitle {
    switch (status) {
      case ExpenseStatus.review:
        return "It looks like you don't have any expense submitted. Don't worry, this space will be updated as new expense submitted.";
      case ExpenseStatus.approved:
        return "It looks like you don't have any expense approved. Don't worry, this space will be updated as new expense approved.";
      case ExpenseStatus.rejected:
        return "It looks like you don't have any expense rejected. Don't worry, this space will be updated as new expense rejected.";
    }
  }

  String get _sectionTitle {
    switch (status) {
      case ExpenseStatus.review:
        return 'Expense submitted';
      case ExpenseStatus.approved:
        return 'Expense Approved';
      case ExpenseStatus.rejected:
        return 'Expense Rejected';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expense',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _sectionTitle,
            style: const TextStyle(fontSize: 12, color: AppColors.textHint),
          ),
          const SizedBox(height: 28),
          Center(
            child: Column(
              children: [
                // Document illustration
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (i) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        width: 40 - i * 4.0,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  _title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textHint, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}