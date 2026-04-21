// ─── lib/features/expense/views/expense_summary_screen.dart ─

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/expense_summary_controller.dart';
import '../widgets/expense_empty_state.dart';
import '../widgets/expense_record_card.dart';
import '../widgets/expense_stat_box.dart';
import '../widgets/expense_tab_bar.dart';

class ExpenseSummaryScreen extends StatelessWidget {
  ExpenseSummaryScreen({super.key});

  final ExpenseSummaryController _c = Get.put(ExpenseSummaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
          ), // Placeholder for header height
          Container(
            height: 260,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: _buildHeader(),
          ),
          Positioned(
            top: 190,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 400,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBalanceCard(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ExpenseTabBar(controller: _c),
                    ),
                    const SizedBox(height: 16),
                    _buildList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildSubmitButton(),
    );
  }

  // ── Purple header
  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          // Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Expense Summary',
                  style: AppTextStyles.h2.copyWith(color: Colors.white),
                ),
                SizedBox(height: 1),
                Text(
                  'Claim your expenses here.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          // Luggage illustration placeholder
          Positioned(
            right: 0,
            top: 1,
            bottom: 20,
            child: Image.asset(
              'assets/images/expense.png',
              width: 100,
              height: 90,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // ── Balance card ─────────────────────────────────────────

  Widget _buildBalanceCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Transform.translate(
        offset: const Offset(0, -1),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Expense',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Obx(
                () => Text(
                  _c.period.value,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textHint,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: ExpenseStatBox(
                        label: 'Total',
                        dotColor: AppColors.primary,
                        value: '\$${_c.totalExpense.toStringAsFixed(0)}',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ExpenseStatBox(
                        label: 'Review',
                        dotColor: const Color(0xFFFFA500),
                        value: '\$${_c.reviewTotal.toStringAsFixed(0)}',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ExpenseStatBox(
                        label: 'Approved',
                        dotColor: const Color(0xFF00C897),
                        value: '\$${_c.approvedTotal.toStringAsFixed(0)}',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Records list / empty state ───────────────────────────

  Widget _buildList() {
    return Obx(() {
      final records = _c.filteredRecords;
      if (records.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ExpenseEmptyState(status: _c.selectedTab.value),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: records.map((r) => ExpenseRecordCard(record: r)).toList(),
        ),
      );
    });
  }

  // ── Bottom button ─────────────────────────────────────────
  Widget _buildSubmitButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: CustomButton(
          text: 'Submit Expense',
          onPressed: _c.goToSubmitExpense,
        ),
      ),
    );
  }
}
