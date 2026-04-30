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