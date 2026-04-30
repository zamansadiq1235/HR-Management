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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Slightly off-white background
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. The Purple Header
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _buildPurpleBackground(context),
                Positioned(
                  top: 160, // This creates the overlap
                  left: 02,
                  right: 2,
                  child: _buildSummaryCard(),
                ),
              ],
            ),
          ),

          // 2. Padding for the overlap area
          const SliverToBoxAdapter(child: SizedBox(height: 100)),

          // 3. The rest of the scrollable content
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildBurnoutCard(),
                const SizedBox(height: 20),
                _buildTabBar(),
                const SizedBox(height: 20),
                _buildTaskList(),
                const SizedBox(height: 120), // Bottom padding for button
              ]),
            ),
          ),
        ],
      ),
      // Floating or Bottom button
      bottomNavigationBar: _buildCreateButton(),
      extendBody: true, // Allows content to scroll under the button blur
    );
  }

  Widget _buildPurpleBackground(BuildContext context) {
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
          padding: const EdgeInsets.fromLTRB(25.0, 25.0, 10, 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Challanges Awaiting',
                    style: AppTextStyles.h2.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    "Let's tackle your to do list",
                    style: TextStyle(
                      color: Color.fromARGB(255, 226, 221, 241),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              // Your clipboard image
              Image.asset('assets/images/task.png', width: 80),
            ],
          ),
        ),
      ),
    );
  }

  // Refined Summary Card to match UI colors
  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
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
            'Summary of Your Work',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text(
            'Your current task progress',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Row(
              children: [
                _summaryBox(
                  'To Do',
                  _c.toDoCount,
                  const Color(0xFF7B61FF),
                  Icons.code_rounded,
                ),
                const SizedBox(width: 8),
                _summaryBox(
                  'In Progress',
                  _c.inProgressCount,
                  Colors.orange,
                  Icons.access_time,
                ),
                const SizedBox(width: 8),
                _summaryBox(
                  'Done',
                  _c.doneCount,
                  Colors.green,
                  Icons.check_circle_outline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryBox(String title, int count, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 15, color: color),
                const SizedBox(width: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '$count',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

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

  // ── Tab Bar ────────────────────────────────────────────────────────────

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

  // ── Task List ──────────────────────────────────────────────────────────

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

  // ── Bottom Create Button ───────────────────────────────────────────────

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
