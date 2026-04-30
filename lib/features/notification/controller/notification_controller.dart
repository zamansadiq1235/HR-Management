import 'package:get/get.dart';
import '../models/notifi_model.dart';


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

  void deletenotifi(int index) {
    notifications.removeAt(index);
  }
}