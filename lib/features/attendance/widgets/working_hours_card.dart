// ─── lib/features/attendance/widgets/working_hours_card.dart ─

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/attendance_controller.dart';

class WorkingHoursCard extends StatelessWidget {
  const WorkingHoursCard({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AttendanceController>();

    return Container(
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
          //  Static title — no Obx needed ───────
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
            style: TextStyle(fontSize: 11.5, color: AppColors.textHint),
          ),
          const SizedBox(height: 14),

          //  Hour boxes — each has its own Obx 
          Row(
            children: [
              Expanded(child: _TodayHourBox(controller: c)),
              const SizedBox(width: 10),
              Expanded(child: _PayPeriodHourBox(controller: c)),
            ],
          ),
          const SizedBox(height: 14),

          //  Action buttons ─────────────────────
          _ActionButtons(controller: c),
        ],
      ),
    );
  }
}

//  Today hour box — owns its own Obx ───────────────────────
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

//  Pay period box — owns its own Obx ───────────────────────
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

//  Hour stat box — pure display, no Obx ────────────────────
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
              const Icon(
                Icons.access_time_rounded,
                size: 13,
                color: AppColors.textHint,
              ),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: AppColors.textHint),
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

//  Action buttons — Obx is THE OUTERMOST widget here ───────

class _ActionButtons extends StatelessWidget {
  final AttendanceController controller;
  const _ActionButtons({required this.controller});

  @override
  Widget build(BuildContext context) {
    
    return Obx(() {
      final state = controller.clockState.value;

      switch (state) {
        //  Not clocked in yet ─────────────────
        case ClockState.clockedOut:
          return _FullButton(
            label: 'Clock In Now',
            onTap: controller.goToClockInArea,
            active: true,
          );

        //  Working 
        case ClockState.clockedIn:
          return Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.takeBreak,
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

        //  On break ───────────────────────────
        case ClockState.onBreak:
          return Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: controller.backToWork,
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

        //  Clocked out for today ──────────────
        case ClockState.finished:
          return _FullButton(label: 'Clocked Out', onTap: null, active: false);
      }
    });
  }
}

//  Full-width button helper ─────────────────────────────────
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
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: active
              ? AppColors.primary
              : AppColors.primarySurface,
          disabledBackgroundColor: AppColors.primarySurface,
          foregroundColor: active ? Colors.white : AppColors.primary,
          disabledForegroundColor: AppColors.primary.withOpacity(0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}
