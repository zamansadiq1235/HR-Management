
enum TaskStatus { toDo, inProgress, done }
enum TaskPriority { low, medium, high }
enum TaskDifficulty { veryEasy, easy, moderate, intermediate, advanced }

extension TaskStatusLabel on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.toDo: return 'To Do';
      case TaskStatus.inProgress: return 'In Progress';
      case TaskStatus.done: return 'Done';
    }
  }
}

extension TaskPriorityLabel on TaskPriority {
  String get label {
    switch (this) {
      case TaskPriority.low: return 'Low';
      case TaskPriority.medium: return 'Medium';
      case TaskPriority.high: return 'High';
    }
  }
}

extension TaskDifficultyLabel on TaskDifficulty {
  String get label {
    switch (this) {
      case TaskDifficulty.veryEasy: return 'Very Easy (Less Than a Day)';
      case TaskDifficulty.easy: return 'Easy (A Day)';
      case TaskDifficulty.moderate: return 'Moderate (3 Days)';
      case TaskDifficulty.intermediate: return 'Intermediate (5 Days)';
      case TaskDifficulty.advanced: return 'Advanced (1 Week)';
    }
  }
}

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String assignee;
  final String assigneeRole;
  final TaskPriority priority;
  final TaskDifficulty difficulty;
  final TaskStatus status;
  final String createdDate;
  final List<String> attachments;
  final List<String> memberAvatars;
  final int commentCount;
  final double progress;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.assigneeRole,
    required this.priority,
    required this.difficulty,
    required this.status,
    required this.createdDate,
    this.attachments = const [],
    this.memberAvatars = const [],
    this.commentCount = 0,
    this.progress = 0.0,
  });
}