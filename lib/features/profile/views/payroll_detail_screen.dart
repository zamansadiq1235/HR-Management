import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/profile_model.dart';
import '../widgets/bottom_btn.dart';
import '../widgets/profile_appBar.dart';

class PayrollDetailScreen extends StatelessWidget {
  final PayrollMonthModel month;
  const PayrollDetailScreen({super.key, required this.month});

  static const _detail = PayrollDetailModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CustomAppBar(title: 'Payroll and Tax',),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        child: Column(
          children: [
            //  Hours summary card ───────────────
            Container(
              padding: const EdgeInsets.all(18),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Working Hour',
                      style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      )),
                  const SizedBox(height: 2),
                  Text(_detail.period,
                      style: const TextStyle(
                          fontSize: 11.5, color: AppColors.textHint)),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _HourBox(
                            label: 'Overtime',
                            value: '${_detail.overtimeHrs} Hrs'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _HourBox(
                            label: 'This Pay Period',
                            value: '${_detail.payPeriodHrs} Hrs'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            //  Payroll detail card 
            Container(
              padding: const EdgeInsets.all(18),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Payroll Details',
                      style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      )),
                  const SizedBox(height: 2),
                  const Text('Details about payroll',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.textHint)),
                  const Divider(height: 24, color: Color(0xFFF0F0F5)),

                  _PayrollRow(
                      label: 'Basic Salary',
                      value: '\$${_detail.basicSalary.toStringAsFixed(2)}',
                      color: AppColors.textPrimary),
                  const SizedBox(height: 14),
                  _PayrollRow(
                      label: 'Tax',
                      value: '-\$${_detail.tax.toStringAsFixed(2)}',
                      color: const Color(0xFFE53935)),
                  const SizedBox(height: 14),
                  _PayrollRow(
                      label: 'Reimbursement',
                      value: '+\$${_detail.reimbursement.toStringAsFixed(2)}',
                      color: const Color(0xFF00C897)),
                  const SizedBox(height: 14),
                  _PayrollRow(
                      label: 'Bonus',
                      value: '+\$${_detail.bonus.toStringAsFixed(2)}',
                      color: const Color(0xFF00C897)),
                  const SizedBox(height: 14),
                  _PayrollRow(
                      label: 'Overtime',
                      value: '\$${_detail.overtime.toStringAsFixed(2)}',
                      color: AppColors.textPrimary),
                  const Divider(height: 24, color: Color(0xFFF0F0F5)),
                  _PayrollRow(
                      label: 'Total Salary',
                      value:
                          '\$${_detail.totalSalary.toStringAsFixed(2)}',
                      color: AppColors.textPrimary,
                      bold: true),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonWrapper(
        label: 'Save As PDF',
        onTap: () => _showSavePdfSheet(context),
      ),
    );
  }

  void _showSavePdfSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 28),
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Container(
              width: 76, height: 76,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.35),
                    blurRadius: 18, offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(Icons.download_rounded,
                  color: Colors.white, size: 36),
            ),
            const SizedBox(height: 20),
            const Text('Payroll Saved!',
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                )),
            const SizedBox(height: 10),
            const Text(
              'Your payroll has been successfully saved.\nYou can check it on your device storage.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13.5, color: AppColors.textHint, height: 1.5),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity, height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                child: const Text('Close Message'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HourBox extends StatelessWidget {
  final String label;
  final String value;
  const _HourBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8FB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEF5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(Icons.access_time_rounded,
                  size: 12, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text(label,
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textHint)),
            ]),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                )),
          ],
        ),
      );
}

class _PayrollRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool bold;
  const _PayrollRow({
    required this.label,
    required this.value,
    required this.color,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: bold ? 14 : 13.5,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
                color: AppColors.textPrimary,
              )),
          Text(value,
              style: TextStyle(
                fontSize: bold ? 14 : 13.5,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                color: color,
              )),
        ],
      );
}
