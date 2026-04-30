// ─── lib/features/attendance/screens/selfie_clock_in_screen.dart

// ignore_for_file: deprecated_member_use, unnecessary_underscores

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../leave/widgets/leave_description_field.dart';
import '../controllers/attendance_controller.dart';

class SelfieClockInScreen extends StatefulWidget {
  /// The file path returned by the camera picker.
  final String imagePath;

  const SelfieClockInScreen({super.key, required this.imagePath});

  @override
  State<SelfieClockInScreen> createState() => _SelfieClockInScreenState();
}

class _SelfieClockInScreenState extends State<SelfieClockInScreen> {
  final _notesController = TextEditingController();
  late String _currentImagePath;

  final AttendanceController _c = Get.put(AttendanceController());

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.imagePath;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  //  Retake — reopens camera and replaces image ──────────────
  Future<void> _retakePhoto() async {
    final newPath = await _c.capturePhoto();
    if (newPath != null) {
      setState(() => _currentImagePath = newPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Selfie image + overlay ──────────
              _SelfieImageSection(
                imagePath: _currentImagePath,
                controller: _c,
                onRetake: _retakePhoto,
              ),

              //  Notes field
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Clock In Notes (Optional)',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DescriptionField(
                      hint: 'Clock-in Notes',
                      maxLines: 4,
                      controller: _notesController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildClockInButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.primary,
            size: 25,
          ),
        ),
      ),
      title: const Text(
        'Selfie To Clock In',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildClockInButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: CustomButton(
          text: 'Clock In',
          onPressed: () {
            _c.performClockIn(_currentImagePath, _notesController.text);
            _showSuccessSheet();
          },
        ),
      ),
    );
  }

  void _showSuccessSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (_) => _ClockInSuccessSheet(),
    );
  }
}

//  Selfie image section ─────────────────────────────────────
class _SelfieImageSection extends StatefulWidget {
  final String imagePath;
  final AttendanceController controller;
  final VoidCallback onRetake;

  const _SelfieImageSection({
    required this.imagePath,
    required this.controller,
    required this.onRetake,
  });

  @override
  State<_SelfieImageSection> createState() => _SelfieImageSectionState();
}

class _SelfieImageSectionState extends State<_SelfieImageSection> {
  late DateTime _currentDateTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentDateTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _currentDateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedDateTime {
    final date = _currentDateTime;
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString().substring(2);
    final hour = date.hour == 0 || date.hour == 12 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final offset = date.timeZoneOffset;
    final sign = offset.isNegative ? '-' : '+';
    final offsetHours = offset.inHours.abs().toString().padLeft(2, '0');
    final offsetMinutes = (offset.inMinutes.abs() % 60).toString().padLeft(
      2,
      '0',
    );
    return '$day/$month/$year ${hour.toString().padLeft(2, '0')}:$minute$amPm GMT $sign$offsetHours:$offsetMinutes';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //  Real captured image
        SizedBox(
          width: double.infinity,
          height: 340,
          child: Image.file(
            File(widget.imagePath),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFF2D2D3A),
              child: const Center(
                child: Icon(Icons.person, color: Colors.white38, size: 80),
              ),
            ),
          ),
        ),

        //  Geo + timestamp overlay
        Positioned(
          left: 16,
          bottom: 60,
          right: 16,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _GeoText('Lat : ${widget.controller.userLat.value}'),
                _GeoText('Long : ${widget.controller.userLng.value}'),
                _GeoText(_formattedDateTime),
              ],
            ),
          ),
        ),

        //  Retake button
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: widget.onRetake,
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: const Text('Retake Photo'),
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GeoText extends StatelessWidget {
  final String text;
  const _GeoText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
      ),
    );
  }
}

//  Clock-In Success Sheet
class _ClockInSuccessSheet extends StatelessWidget {
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
                'Clock-In Successful!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "You're all set! Your clock-in was successful.\nHead over to your dashboard to see your assigned tasks.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Get.until(
                    (route) =>
                        route.settings.name == '/attendance' || route.isFirst,
                  ),
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
                  child: const Text('Go To Clock In Page'),
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
              Icons.person_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
      ],
    );
  }
}
