// ─── lib/features/profile/screens/payroll_screen.dart ───────

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../models/profile_model.dart';
import '../widgets/profile_appBar.dart';
import 'payroll_detail_screen.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});

  static const _months = [
    PayrollMonthModel(
        month: 'September 2024',
        totalHours: '40:00:00 hrs',
        received: '\$800',
        paidOn: '30 Sept 2024'),
    PayrollMonthModel(
        month: 'August 2024',
        totalHours: '40:00:00 hrs',
        received: '\$800',
        paidOn: '30 Aug 2024'),
    PayrollMonthModel(
        month: 'July 2024',
        totalHours: '40:00:00 hrs',
        received: '\$800',
        paidOn: '30 Jul 2024'),
    PayrollMonthModel(
        month: 'June 2024',
        totalHours: '40:00:00 hrs',
        received: '\$800',
        paidOn: '30 Jun 2024'),
    PayrollMonthModel(
        month: 'May 2024',
        totalHours: '40:00:00 hrs',
        received: '\$800',
        paidOn: '30 May 2024'),
    PayrollMonthModel(
        month: 'April 2024',
        totalHours: '40:00:00 hrs',
        received: '\$800',
        paidOn: '30 Apr 2024'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CustomAppBar(title: 'Payroll and Tax',),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          children: _months
              .map((m) => GestureDetector(
                    onTap: () => Get.to(() => PayrollDetailScreen(month: m)),
                    child: _PayrollMonthCard(model: m),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _PayrollMonthCard extends StatelessWidget {
  final PayrollMonthModel model;
  const _PayrollMonthCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10, offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model.month,
              style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              )),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8FB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEEEEF5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PayrollStat(label: 'Total Hours', value: model.totalHours),
                _PayrollStat(label: 'Received', value: model.received),
                _PayrollStat(label: 'Paid On', value: model.paidOn),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PayrollStat extends StatelessWidget {
  final String label;
  final String value;
  const _PayrollStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 10.5, color: AppColors.textHint)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              )),
        ],
      );
}
