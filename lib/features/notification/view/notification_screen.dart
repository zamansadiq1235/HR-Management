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
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Color(0xFF1E212C),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        return ListView.separated(
          itemCount: controller.notifications.length,
          separatorBuilder: (context, index) =>
              const Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1)),
          itemBuilder: (context, index) {
            final item = controller.notifications[index];
            return NotificationTile(notification: item);
          },
        );
      }),
    );
  }
}
