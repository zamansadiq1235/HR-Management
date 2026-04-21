// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hrmanagement/core/constants/app_assets.dart';
import 'package:hrmanagement/core/constants/app_colors.dart';
import 'package:hrmanagement/features/notification/view/notification_screen.dart';
import 'package:hrmanagement/features/profile/views/profile_screen.dart';
import '../../messages/view/messagelist_screen.dart';
import '../controller/home_view_model.dart';
import '../widgets/meeting_card.dart';
import '../widgets/task_card.dart';
import '../widgets/summary_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: ListView(
            children: [
              /// HEADER
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.to(MyProfileScreen()),
                    child: SizedBox(
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(
                              "assets/images/Ellipse2.png",
                            ),
                          ),
                          const SizedBox(width: 8),

                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Tonald Drump",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.verified,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ],
                              ),
                              Text(
                                "Junior Full Stack Developer",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  InkWell(
                    onTap: () => Get.to(MessageListScreen()),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primaryLight.withOpacity(0.2),
                      child: SvgPicture.asset(
                        AppAssets.smsfilled,
                        width: 22,
                        height: 22,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primaryLight.withOpacity(0.2),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        size: 22,
                        color: AppColors.primary,
                      ),
                      onPressed: () => Get.to(NotificationScreen()),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const SummaryCard(),

              const SizedBox(height: 20),

              /// MEETINGS
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  border: Border.all(
                    color: AppColors.bottomNavInactive,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Today Meeting",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              controller.meetingCount.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Your schedule for the day ",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.bottomNavInactive,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Obx(
                      () => Column(
                        children: controller.meetings
                            .map((m) => MeetingCard(meeting: m))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// TASKS
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  border: Border.all(
                    color: AppColors.bottomNavInactive,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Today Tasks",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              controller.taskCount.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "The tasks managed to you for today",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.bottomNavInactive,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Obx(
                      () => Column(
                        children: controller.tasks
                            .map((t) => TaskCard(task: t))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
