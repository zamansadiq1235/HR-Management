// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/attendance_controller.dart';

class WorkingHoursCard extends StatelessWidget {
  const WorkingHoursCard({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController c = Get.isRegistered<AttendanceController>()
        ? Get.find<AttendanceController>()
        : Get.put(AttendanceController());

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Working Hour',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Paid Period 1 Sept 2024 - 30 Sept 2024',
            style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(child: _TodayHourBox(controller: c)),
              const SizedBox(width: 10),
              Expanded(child: _PayPeriodHourBox(controller: c)),
            ],
          ),
          const SizedBox(height: 14),

          _ActionButtons(controller: c),
        ],
      ),
    );
  }
}

class _TodayHourBox extends StatelessWidget {
  final AttendanceController controller;

  const _TodayHourBox({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _HourBox(label: 'Today', value: controller.todayHours.value),
    );
  }
}

class _PayPeriodHourBox extends StatelessWidget {
  final AttendanceController controller;

  const _PayPeriodHourBox({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _HourBox(
        label: 'This Pay Period',

        value: controller.payPeriodHours.value,
      ),
    );
  }
}

class _HourBox extends StatelessWidget {
  final String label;

  final String value;

  const _HourBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),

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
              Icon(
                Icons.access_time_rounded,

                size: 13,

                color: AppColors.textSecondary,
              ),

              const SizedBox(width: 5),

              Text(
                label,

                style: const TextStyle(
                  fontSize: 11,

                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            value,

            style: const TextStyle(
              fontSize: 20,

              fontWeight: FontWeight.w700,

              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final AttendanceController controller;
  const _ActionButtons({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = controller.clockState.value;

      switch (state) {
        case ClockState.clockedOut:
          return _FullButton(
            label: 'Clock In Now',
            onTap: () {
              print("Clock In Button Tapped");
              controller.goToClockInArea();
            },
            active: true,
          );

        case ClockState.clockedIn:
          return Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => controller.takeBreak(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(
                      color: AppColors.primary,
                      width: 1.4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: const Text(
                    'Take A Break',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => controller.showClockOutConfirm(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A2E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: const Text(
                    'Clock Out',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          );

        case ClockState.onBreak:
          return Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => controller.backToWork(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: const Text(
                    'Back To Work',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => controller.showClockOutConfirm(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A2E),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: const Text(
                    'Clock Out',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          );

        case ClockState.finished:
          return _FullButton(label: 'Clocked Out', onTap: null, active: false);
      }
    });
  }
}

class _FullButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool active;

  const _FullButton({
    required this.label,
    required this.onTap,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: active
              ? AppColors.primary
              : AppColors.primarySurface,
          foregroundColor: active ? Colors.white : AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
