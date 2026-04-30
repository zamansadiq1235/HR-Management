// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/leave_summary_controller.dart';
import '../models/leave_model.dart';
import '../widgets/leave_record.dart';
import '../widgets/leave_statbox.dart';

class LeaveSummaryScreen extends StatelessWidget {
  LeaveSummaryScreen({super.key});

  final LeaveSummaryController _c = Get.put(LeaveSummaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Consistant background
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Purple Header with Overlapping Logic
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _buildPurpleHeader(context),
                Positioned(
                  top: 160, // TaskMenu style overlap
                  left: 0,
                  right: 0,
                  child: _buildLeaveBalanceCard(),
                ),
              ],
            ),
          ),

          // 2. Space for the overlapping card
          const SliverToBoxAdapter(child: SizedBox(height: 100)),

          // 3. Tab Bar and Leave List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildTabBar(),
                const SizedBox(height: 20),
                const Text(
                  'Recent Leave Requests',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildLeaveList(),
                const SizedBox(height: 120), // Padding for fixed bottom button
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildSubmitButton(),
      extendBody: true,
    );
  }

  // ── Purple Header
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
                    'Leave Summary',
                    style: AppTextStyles.h2.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const Text(
                    'Submit and track your leaves',
                    style: TextStyle(
                      color: Color.fromARGB(255, 226, 221, 241),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              // Illustrations
              Stack(
                children: [
                  Image.asset('assets/images/leave.png', width: 90),
                  Positioned(
                    bottom: 0,
                    //right: 0,
                    left: 10,
                    child: Image.asset('assets/images/leave2.png', width: 55),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Overlapping Balance Card
  Widget _buildLeaveBalanceCard() {
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
            'Leave Balance',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Obx(
            () => Text(
              '${_c.periodStart.value} - ${_c.periodEnd.value}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: LeaveStatBox(
                  label: 'Available',
                  dotColor: AppColors.accentGreen,
                  valueObs: _c.totalAvailable,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: LeaveStatBox(
                  label: 'Leave Used',
                  dotColor: AppColors.primary,
                  valueObs: _c.leaveUsed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Tab Bar (Updated for consistent style)
  Widget _buildTabBar() {
    return Obx(() {
      final selected = _c.selectedTab.value;
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: LeaveStatus.values.map((status) {
            final isSelected = selected == status;
            final label =
                status.name[0].toUpperCase() + status.name.substring(1);
            return Expanded(
              child: GestureDetector(
                onTap: () => _c.selectTab(status),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  // ── Leave List
  Widget _buildLeaveList() {
    return Obx(() {
      final records = _c.filteredRecords;
      if (records.isEmpty) {
        return _buildEmptyState();
      }
      return Column(
        children: records.map((r) => LeaveRecordCard(record: r)).toList(),
      );
    });
  }

  // ── Empty State
  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            Icons.luggage_rounded,
            size: 60,
            color: AppColors.primary.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          const Text(
            'No records found',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            'Tap "Submit Leave" to start.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ── Bottom Button
  Widget _buildSubmitButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: CustomButton(
          text: 'Submit Leave',
          onPressed: _c.goToSubmitLeave,
        ),
      ),
    );
  }
}
