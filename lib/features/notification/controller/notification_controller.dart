import 'package:get/get.dart';
import '../models/notifi_model.dart';

class NotificationController extends GetxController {
  // Observable list of notifications
  final notifications = <NotificationModel>[
    NotificationModel(
      title: "New Task Assigned to You!",
      subtitle:
          "You have new task for this sprint from Alicia, you can check your task \"Create Onboarding Screen\" by tap here",
      time: "09.10",
      iconPath: 'assets/icons/task_icon.png',
    ),
    NotificationModel(
      title: "Expense has been approved!",
      subtitle:
          "Your expense has been been approved by jessica, view expense report here",
      time: "09.10",
      iconPath: 'assets/icons/expense_icon.png',
    ),
    NotificationModel(
      title: "You have invited in meeting!",
      subtitle:
          "You have been invited to a meeting. Tap to find the meeting details",
      time: "09.10",
      iconPath: 'assets/icons/meeting_icon.png',
    ),
  ].obs;

  // Track selection state
  var selectedIndices = <int>{}.obs;
  var isSelectionMode = false.obs;

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
      if (selectedIndices.isEmpty) isSelectionMode.value = false;
    } else {
      selectedIndices.add(index);
      isSelectionMode.value = true;
    }
  }

  void clearSelection() {
    selectedIndices.clear();
    isSelectionMode.value = false;
  }

  void deleteSelected() {
    // Sort indices descending to prevent range errors while removing
    List<int> sorted = selectedIndices.toList()..sort((a, b) => b.compareTo(a));
    for (var index in sorted) {
      notifications.removeAt(index);
    }
    clearSelection();
  }

  void deletenotifi(int index) {
    notifications.removeAt(index);
    // If we were selecting this item, also update selection state
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
      if (selectedIndices.isEmpty) isSelectionMode.value = false;
    }
  }
}
