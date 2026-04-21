class TaskModel {
  final String title;
  final String status;
  final String priority;
  final String date;
  final int comments;
  final double progress;
  final List<String> members;

  TaskModel({
    required this.title,
    required this.status,
    required this.priority,
    required this.date,
    required this.comments,
    this.progress = 0.65,
    this.members = const [],
  });
}
