// ─── lib/features/attendance/controllers/attendance_controller.dart

// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmanagement/core/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../models/attendance_model.dart';
import '../view/clock_in_area_screen.dart';
import '../view/selfie_clockin_screen.dart';

/// All possible clock states shown on the main screen
enum ClockState {
  clockedOut, // Not yet clocked in today → "Clock In Now" (purple)
  clockedIn, // Clocked in, working      → "Take A Break" + "Clock Out"
  onBreak, // On break                 → "Back To Work" + "Clock Out"
  finished, // Clocked out for today    → "Clocked Out" (disabled)
}

class AttendanceController extends GetxController {
  // ── Clock state
  final clockState = ClockState.clockedOut.obs;

  // ── Working hours display
  final todayHours = '00:00 Hrs'.obs;
  final payPeriodHours = '32:00 Hrs'.obs;

  // ── Timer for live elapsed time
  Timer? _timer;
  DateTime? _clockInTime;
  int _elapsedSeconds = 0;

  final ImagePicker _picker = ImagePicker();

  // ── Clock-in area / selfie data
  final userLat = '45.43534'.obs;
  final userLng = '97897.576'.obs;
  final selfieImagePath = RxnString(); // null = no selfie yet
  final clockInNotes = ''.obs;
  final clockInTime = RxnString(); // e.g. "09:00 AM"
  final clockOutTime = RxnString();

  // ── Attendance history
  final attendanceList = <AttendanceModel>[
    const AttendanceModel(
      date: '27 September 2024',
      totalHours: '08:00:00 hrs',
      clockIn: '09:00 AM',
      clockOut: '05:00 PM',
    ),
    const AttendanceModel(
      date: '26 September 2024',
      totalHours: '08:00:00 hrs',
      clockIn: '09:00 AM',
      clockOut: '05:00 PM',
    ),
    const AttendanceModel(
      date: '25 September 2024',
      totalHours: '08:10:00 hrs',
      clockIn: '09:00 AM',
      clockOut: '05:10 PM',
    ),
  ].obs;

  // ── Computed helpers
  bool get isClockedOut => clockState.value == ClockState.clockedOut;
  bool get isClockedIn => clockState.value == ClockState.clockedIn;
  bool get isOnBreak => clockState.value == ClockState.onBreak;
  bool get isFinished => clockState.value == ClockState.finished;

  /// Called from ClockInAreaScreen "Selfie To Clock In" button

  Future<String?> capturePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 85,
    );
    return photo?.path;
  }

  Future<void> goToSelfie() async {
    final path = await capturePhoto();
    if (path == null) return; // user cancelled
    Get.to(() => SelfieClockInScreen(imagePath: path));
  }

  // ── Navigation
  Future<void> goToClockInArea() async {
    Get.to(() => ClockInAreaScreen());
  }

  //void goToSelfie() => Get.toNamed(AppRoutes.selfieClockin);
  void goToDetail(AttendanceModel attendance) =>
      Get.toNamed(AppRoutes.attendanceDetail, arguments: attendance);

  // ── Actions

  void performClockIn(String? imagePath, String notes) {
    selfieImagePath.value = imagePath;
    clockInNotes.value = notes;
    final now = TimeOfDay.now();
    clockInTime.value =
        '${now.hourOfPeriod.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.period.name.toUpperCase()}';
    clockState.value = ClockState.clockedIn;
    _startTimer();

    // Add a today record at the top
    _addTodayRecord('—');
  }

  void takeBreak() {
    clockState.value = ClockState.onBreak;
    _stopTimer();
  }

  void backToWork() {
    clockState.value = ClockState.clockedIn;
    _startTimer();
  }

  void showClockOutConfirm(BuildContext context) {
    // Imported inline to avoid circular deps; caller passes context
    _showClockOutSheet(context);
  }

  void performClockOut() {
    _stopTimer();
    final now = TimeOfDay.now();
    clockOutTime.value =
        '${now.hourOfPeriod.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.period.name.toUpperCase()}';
    clockState.value = ClockState.finished;
    todayHours.value = '08:00 Hrs'; // in real app compute from timer
    _updateTodayRecord();
  }

  // ── Timer helpers
  void _startTimer() {
    _clockInTime ??= DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedSeconds++;
      final h = (_elapsedSeconds ~/ 3600).toString().padLeft(2, '0');
      final m = ((_elapsedSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
      todayHours.value = '$h:$m Hrs';
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // ── Record helpers ───────────────────────────────────────
  void _addTodayRecord(String clockOutVal) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final now = DateTime.now();
    final dateStr = '${now.day} ${months[now.month]} ${now.year}';
    attendanceList.insert(
      0,
      AttendanceModel(
        date: dateStr,
        totalHours: '—',
        clockIn: clockInTime.value ?? '—',
        clockOut: clockOutVal,
        selfieImagePath: selfieImagePath.value,
        clockInNotes: clockInNotes.value,
        lat: userLat.value,
        lng: userLng.value,
      ),
    );
  }

  void _updateTodayRecord() {
    if (attendanceList.isNotEmpty) {
      final old = attendanceList[0];

      // 1. Update the item
      attendanceList[0] = AttendanceModel(
        date: old.date,
        totalHours: todayHours.value.replaceAll(' Hrs', ':00 hrs'),
        clockIn: old.clockIn,
        clockOut: clockOutTime.value ?? '—',
        selfieImagePath: old.selfieImagePath,
        clockInNotes: old.clockInNotes,
        lat: old.lat,
        lng: old.lng,
      );

      // 2. CRITICAL: Tell GetX the list has changed
      attendanceList.refresh();
    }
  }

  void _showClockOutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ClockOutConfirmSheet(controller: this),
    );
  }

  @override
  void onClose() {
    _stopTimer();
    super.onClose();
  }
}

// ── Clock-out confirm sheet ──────────────────────────────────
// Kept here to avoid extra file; import from widgets file in real project.

class _ClockOutConfirmSheet extends StatelessWidget {
  final AttendanceController controller;
  const _ClockOutConfirmSheet({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
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
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Confirm Clockout',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Once you clock out, you won't be able to edit this time. Please double-check your hours before proceeding.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _SummaryBox(label: 'Today', value: '08:00:00 Hrs'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _SummaryBox(
                      label: 'Overtime',
                      value: '00:00:00 Hrs',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: CustomButton(
                  text: 'Yes, Clock Out',
                  onPressed: () {
                    Get.back();
                    controller.performClockOut();
                    _showSuccessSheet(context);
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(
                      color: AppColors.primary,
                      width: 1.4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('No, Let me check'),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -38,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.access_time_filled,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
      ],
    );
  }

  void _showSuccessSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _ClockOutSuccessSheet(),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
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
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ClockOutSuccessSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
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
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Clockout Successful!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "You've officially clocked out for the day. Thank you for your hard work! Time to relax and enjoy your break.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textHint,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Close Message'),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -38,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.access_time_filled,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
      ],
    );
  }
}
