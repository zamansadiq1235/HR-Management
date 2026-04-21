// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrmanagement/core/widgets/custom_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../controllers/task_menu_controller.dart';
import '../widgets/task_card_widget.dart';
import '../widgets/task_widgets.dart';

class TaskMenuScreen extends StatelessWidget {
  TaskMenuScreen({super.key});

  final TaskMenuController _c = Get.put(TaskMenuController());

  static const _purple = AppColors.primary;

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
            height: 255,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
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
                    _buildSummaryCard(),
                    const SizedBox(height: 16),
                    _buildBurnoutCard(),
                    const SizedBox(height: 16),
                    _buildTabBar(),
                    const SizedBox(height: 16),
                    _buildTaskList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildCreateButton(),
    );
  }

  //  Purple Header

  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          // Text
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Challanges Awaiting',
                  style: AppTextStyles.h2.copyWith(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  "Let's tackle your to do list",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Luggage illustration placeholder
          Positioned(
            right: 20,
            top: 0,
            bottom: 60,
            child: Image.asset(
              'assets/images/task.png',
              width: 90,
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  //  Summary Card
  Widget _buildSummaryCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Transform.translate(
        offset: const Offset(0, -1),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
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
                'Summary of Your Work',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Your current task progress',
                style: TextStyle(fontSize: 12, color: AppColors.textHint),
              ),
              const SizedBox(height: 12),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: TaskSummaryBox(
                        label: 'To Do',
                        count: _c.toDoCount,
                        dotColor: _purple,
                        icon: Icons.radio_button_unchecked_rounded,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TaskSummaryBox(
                        label: 'In Progress',
                        count: _c.inProgressCount,
                        dotColor: const Color(0xFFFFA500),
                        icon: Icons.timelapse_rounded,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TaskSummaryBox(
                        label: 'Done',
                        count: _c.doneCount,
                        dotColor: const Color(0xFF00C897),
                        icon: Icons.check_circle_rounded,
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

  //  Burnout Card
  Widget _buildBurnoutCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() {
        final isGood = _c.burnoutLevel == BurnoutLevel.good;
        return BurnoutCard(
          title: _c.sprintLabel,
          statusLabel: isGood ? 'Good' : 'Poor',
          statusColor: isGood
              ? const Color(0xFF00C897)
              : const Color(0xFFFFA500),
          statusTextColor: Colors.white,
          message: _c.burnoutMessage,
          progress: _c.burnoutProgress,
          progressColor: isGood
              ? const Color(0xFF00C897)
              : const Color(0xFFFFA500),
          onTap: _c.goToBurnoutStats,
        );
      }),
    );
  }

  //  Tab Bar
  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () => TaskTabBar(
          selectedIndex: _c.selectedTabIndex.value,
          counts: [
            _c.toDoCount + _c.inProgressCount + _c.doneCount,
            _c.inProgressCount,
            _c.doneCount,
          ],
          onTabChanged: _c.selectTab,
        ),
      ),
    );
  }

  //  Task list / empty state
  Widget _buildTaskList() {
    return Obx(() {
      final tasks = _c.filteredTasks;
      if (tasks.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TaskEmptyState(),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'Today Task',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            ...tasks.map(
              (t) => TaskCardWidget(task: t, onTap: () => _c.goToDetail(t)),
            ),
          ],
        ),
      );
    });
  }

  //  Bottom create button
  Widget _buildCreateButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: CustomButton(text: 'Create Task', onPressed: _c.goToCreateTask),
      ),
    );
  }
}
