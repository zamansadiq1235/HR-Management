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
      backgroundColor: const Color(0xFFF8F9FD),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    SizedBox(height: 350, width: double.infinity),
                    Container(
                      height: 240,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: _buildHeaderContent(context),
                    ),
                    Positioned(
                      bottom: -40,
                      left: 16,
                      right: 16,
                      child: SizedBox(height: 240, child: WorkingHoursCard()),
                    ),
                  ],
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 60)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: Obx(() {
                  final list = controller.attendanceList;

                  if (list.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "No Records Found",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final e = list[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AttendanceCard(
                          attendance: e,
                          onTap: () => controller.goToDetail(e),
                        ),
                      );
                    }, childCount: list.length),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 10, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's Clock-In!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  "Don't miss your clock in schedule",
                  style: TextStyle(
                    color: Color.fromARGB(255, 226, 221, 241),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/attendant.png', width: 85),
          ],
        ),
      ),
    );
  }
}
