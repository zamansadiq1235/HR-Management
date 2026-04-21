import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../attendance/view/attendance_screen.dart';
import '../../expense/view/expense_summary_screen.dart';
import '../../home/view/home_view.dart';
import '../../leave/view/leave_summary_screen.dart';
import '../../taskmenu/view/task_menu_screen.dart';
import '../controller/navbar_controller.dart';
import '../widgets/bottom_navbar.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  final controller = Get.put(NavBarController());

  final List<Widget> pages = [
    HomeScreen(),
    ClockInScreen(),
    TaskMenuScreen(),
    ExpenseSummaryScreen(),
    LeaveSummaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),

      bottomNavigationBar: BottomNavbar(),
    );
  }
}
