import 'package:get/get.dart';

class NotificationModel {
  final String title;
  final String subtitle;
  final String time;
  final String iconPath; // For asset icons or category types

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.iconPath,
  });
}

class NotificationController extends GetxController {
  // Observable list of notifications
  final notifications = <NotificationModel>[
    NotificationModel(
      title: "New Task Assigned to You!",
      subtitle: "You have new task for this sprint from Alicia, you can check your task \"Create Onboarding Screen\" by tap here",
      time: "09.10",
      iconPath: 'assets/icons/task_icon.png',
    ),
    NotificationModel(
      title: "Expense has been approved!",
      subtitle: "Your expense has been been approved by jessica, view expense report here",
      time: "09.10",
      iconPath: 'assets/icons/expense_icon.png',
    ),
    NotificationModel(
      title: "You have invited in meeting!",
      subtitle: "You have been invited to a meeting. Tap to find the meeting details",
      time: "09.10",
      iconPath: 'assets/icons/meeting_icon.png',
    ),
  ].obs;
}