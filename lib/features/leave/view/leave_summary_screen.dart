// ─── lib/views/leave_summary_screen.dart ───────────────────

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
                    _buildLeaveBalanceCard(),
                    const SizedBox(height: 20),
                    _buildTabBar(),
                    const SizedBox(height: 16),
                    _buildLeaveList(),
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

  // ── Purple Header ───────────────────────────────────────
  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          // Luggage illustration placeholder
          Positioned(
            right: 0,
            top: 30,
            bottom: 0,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/leave.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  left: 0,
                  top: 10,
                  child: Image.asset(
                    'assets/images/leave2.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          // Text
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Leave Summary',
                  style: AppTextStyles.h2.copyWith(color: Colors.white),
                ),
                SizedBox(height: 2),
                Text(
                  'Submit Leave',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Leave Balance Card ──────────────────────────────────
  Widget _buildLeaveBalanceCard() {
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
                'Total Leave',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Obx(
                () => Text(
                  '${_c.periodStart.value} - ${_c.periodEnd.value}',
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              IntrinsicHeight(
                child: Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Tab Bar ─────────────────────────────────────────────
  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Obx(() {
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
              final reviewCount = status == LeaveStatus.review
                  ? _c.reviewCount
                  : 0;
              return Expanded(
                child: GestureDetector(
                  onTap: () => _c.selectTab(status),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                        if (reviewCount > 0) ...[
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentRed,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$reviewCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }),
    );
  }

  // ── Leave List ──────────────────────────────────────────
  Widget _buildLeaveList() {
    return Obx(() {
      final records = _c.filteredRecords;
      if (records.isEmpty) {
        return _buildEmptyState();
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: records.map((r) => LeaveRecordCard(record: r)).toList(),
        ),
      );
    });
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
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
          children: [
            const Text(
              'Leave Submitted',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Leave information',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 28),
            Icon(
              Icons.luggage_rounded,
              size: 72,
              color: AppColors.primary.withOpacity(0.25),
            ),
            const SizedBox(height: 18),
            const Text(
              'No Leave Submitted!',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Ready to catch some fresh air? Click "Submit Leave" and\ntake that well-deserved break!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  // Submit Button
  Widget _buildSubmitButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: CustomButton(
          text: 'Submit Leave',
          onPressed: () {
            _c.goToSubmitLeave();
          },
        ),
      ),
    );
  }
}
