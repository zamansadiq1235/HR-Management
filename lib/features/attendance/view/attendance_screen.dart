// ignore_for_file: unnecessary_underscores, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/attendance_controller.dart';
import '../widgets/working_hours_card.dart';
import '../widgets/attendance_card.dart';

class ClockInScreen extends StatelessWidget {
  ClockInScreen({super.key});

  final AttendanceController controller = Get.put(AttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          //  Header 
          Container(
            height: 255,
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

          // ── Content ──────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 160, 16, 0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const WorkingHoursCard(),
                const SizedBox(height: 20),

                /// 🔥 FIXED OBX
                Obx(() {
                  final list = controller.attendanceList;

                  // ✅ FIX 1
                  if (list.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text("No Records"),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      // ✅ FIX 2 (use local list)
                      final e = list[index];

                      return AttendanceCard(
                        attendance: e,
                        onTap: () => controller.goToDetail(e),
                      );
                    },
                  );
                }),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Header UI (unchanged) ──────────────────
  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
         
          const Positioned(
            top: 26,
            right: 82,
            child: Icon(Icons.star, color: Colors.white24, size: 9),
          ),

          Positioned(
            right: 20,
            top: 0,
            bottom: 60,
            child: Image.asset(
              'assets/images/attendant.png',
              width: 90,
              height: 80,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.alarm_rounded,
                color: Colors.white.withOpacity(0.25),
                size: 72,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's Clock-In!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Don't miss your clock in schedule",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

