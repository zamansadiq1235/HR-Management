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
      backgroundColor: const Color(0xFFF8F9FD), // Consistant background
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Purple Header with Overlap
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _buildPurpleHeader(context),
                Positioned(
                  top: 160, // Standard overlap height
                  left: 0,
                  right: 0,
                  child: _buildBalanceCard(),
                ),
              ],
            ),
          ),

          // 2. Space for the overlapping card
          const SliverToBoxAdapter(child: SizedBox(height: 100)),

          // 3. Tab Bar and List content
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ExpenseTabBar(controller: _c),
                const SizedBox(height: 20),
                const Text(
                  'Expense Records',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildList(),
                const SizedBox(height: 120), // Padding for bottom button
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildSubmitButton(),
      extendBody: true,
    );
  }

  // ── Purple Header (Matches TaskMenu style)
  Widget _buildPurpleHeader(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 25.0, 0, 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expense Summary',
                    style: AppTextStyles.h2.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const Text(
                    'Claim your expenses here.',
                    style: TextStyle(
                      color: Color.fromARGB(255, 226, 221, 241),
                       fontSize: 13),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/expense.png',
                width: 90,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white24,
                  size: 70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Overlapping Balance Card
  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Expense',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Obx(
            () => Text(
              _c.period.value,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Row(
              children: [
                _statBoxItem('Total', _c.totalExpense, AppColors.primary),
                const SizedBox(width: 8),
                _statBoxItem('Review', _c.reviewTotal, const Color(0xFFFFA500)),
                const SizedBox(width: 8),
                _statBoxItem(
                  'Approved',
                  _c.approvedTotal,
                  const Color(0xFF00C897),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Stat Boxes inside the card
  Widget _statBoxItem(String label, double value, Color color) {
    return Expanded(
      child: ExpenseStatBox(
        label: label,
        dotColor: color,
        value: '\$${value.toStringAsFixed(0)}',
      ),
    );
  }

  // ── Records List
  Widget _buildList() {
    return Obx(() {
      final records = _c.filteredRecords;
      if (records.isEmpty) {
        return ExpenseEmptyState(status: _c.selectedTab.value);
      }
      return Column(
        children: records.map((r) => ExpenseRecordCard(record: r)).toList(),
      );
    });
  }

  // ── Bottom Button (Matches TaskMenu style)
  Widget _buildSubmitButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
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
