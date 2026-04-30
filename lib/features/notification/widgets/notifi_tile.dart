import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/notifi_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onDelete;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback onLongPress;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onDelete,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onLongPress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Dismissible(
        key: ObjectKey(notification),
        // Disable swipe if we are selecting
        direction: isSelectionMode ? DismissDirection.none : DismissDirection.endToStart,
        onDismissed: (_) => onDelete(),
        background: Container(
          color: Colors.redAccent,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
        ),
        child: Container(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container with Selection Overlay
              Stack(
                children: [
                  Container(
                    height: 70, width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.description_outlined, size: 33, color: Color(0xFF7B61FF)),
                  ),
                  if (isSelected)
                    Container(
                      height: 70, width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 30),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(notification.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700))),
                        Text(notification.time, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(notification.subtitle, style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}