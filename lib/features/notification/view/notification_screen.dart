import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/notification_controller.dart';
import '../widgets/notifi_tile.dart'; // Adjust path

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F9FE,
      ), // Very light blue/grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Color(0xFF7B61FF),
              ),
            ),
          ),
        ),
        title: Obx(
          () => Text(
            controller.isSelectionMode.value
                ? '${controller.selectedIndices.length} Selected'
                : 'Notifications',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          Obx(
            () => controller.isSelectionMode.value
                ? IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _showDeleteDialog(context),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            return NotificationTile(
              notification: controller.notifications[index],
              isSelected: controller.selectedIndices.contains(index),
              isSelectionMode: controller.isSelectionMode.value,
              onDelete: () => controller.deletenotifi(index),
              onLongPress: () => controller.toggleSelection(index),
              onTap: () {
                if (controller.isSelectionMode.value) {
                  controller.toggleSelection(index);
                }
              },
            );
          },
        ),
      ),
      // Delete Button appears only when items are selected
    );
  }

  void _showDeleteDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text("Delete Notifications"),
        content: Text(
          "Are you sure you want to delete ${controller.selectedIndices.length} notifications?",
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              controller.deleteSelected();
              Get.back();
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
