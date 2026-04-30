import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../models/task_model.dart';

// Burnout level derived from task count
enum BurnoutLevel { good, poor }

class TaskMenuController extends GetxController {
  // ── Tab ─────────────────────────────────────────────────
  // 0 = All, 1 = In Progress, 2 = Finish
  final selectedTabIndex = 0.obs;

  void selectTab(int i) => selectedTabIndex.value = i;

  // ── Tasks ────────────────────────────────────────────────
  final _tasks = <TaskModel>[
    TaskModel(
      id: '1',
      title: 'Create On Boarding Screen',
      description:
          'Create on boarding page based on pic, pixel perfect, with the user story of i want to know what kind of apps is this so i need to view onboarding screen to leverage my knowledge so that i know what kind of apps is this',
      assignee: 'Alice',
      assigneeRole: 'Sr Front End Developer',
      priority: TaskPriority.high,
      difficulty: TaskDifficulty.veryEasy,
      status: TaskStatus.inProgress,
      createdDate: '27 Sept 2024',
      memberAvatars: ['a', 'b'],
      commentCount: 2,
      progress: 0.65,
      attachments: ['att1', 'att2'],
    ),
    TaskModel(
      id: '2',
      title: 'Wiring Dashboard Analytics',
      description: 'Wire up all analytics charts to live data endpoints.',
      assignee: 'Alice',
      assigneeRole: 'Sr Front End Developer',
      priority: TaskPriority.high,
      difficulty: TaskDifficulty.moderate,
      status: TaskStatus.inProgress,
      createdDate: '27 Sept 2024',
      memberAvatars: ['a', 'b', 'c'],
      commentCount: 2,
      progress: 0.7,
    ),
    TaskModel(
      id: '3',
      title: 'API Dashboard Analytics Integration',
      description: 'Integrate REST APIs with dashboard analytics module.',
      assignee: 'Brahm',
      assigneeRole: 'Mid Front End Developer',
      priority: TaskPriority.high,
      difficulty: TaskDifficulty.intermediate,
      status: TaskStatus.inProgress,
      createdDate: '27 Sept 2024',
      memberAvatars: ['a', 'b'],
      commentCount: 2,
      progress: 0.4,
    ),
    TaskModel(
      id: '4',
      title: 'Slicing Dashboard Analytics',
      description: 'Slice Figma designs into Flutter widgets.',
      assignee: 'Jeane',
      assigneeRole: 'Jr Front End Developer',
      priority: TaskPriority.high,
      difficulty: TaskDifficulty.easy,
      status: TaskStatus.done,
      createdDate: '27 Sept 2024',
      memberAvatars: ['a', 'b', 'c'],
      commentCount: 2,
      progress: 1.0,
    ),
  ].obs;

  // ── Counts ───────────────────────────────────────────────
  int get toDoCount => _tasks.where((t) => t.status == TaskStatus.toDo).length;
  int get inProgressCount =>
      _tasks.where((t) => t.status == TaskStatus.inProgress).length;
  int get doneCount => _tasks.where((t) => t.status == TaskStatus.done).length;

  // ── Filtered tasks based on tab ──────────────────────────
  List<TaskModel> get filteredTasks {
    switch (selectedTabIndex.value) {
      case 0:
        return _tasks.toList();
      case 1:
        return _tasks.where((t) => t.status == TaskStatus.inProgress).toList();
      case 2:
        return _tasks.where((t) => t.status == TaskStatus.done).toList();
      default:
        return _tasks.toList();
    }
  }

  // ── Burnout ──────────────────────────────────────────────
  BurnoutLevel get burnoutLevel =>
      inProgressCount > 3 ? BurnoutLevel.poor : BurnoutLevel.good;

  String get burnoutMessage {
    if (burnoutLevel == BurnoutLevel.poor) {
      return "You've completed 8 more tasks than usual, maintain your task with your supervisor";
    }
    return "You've maintain your task at the right pace! keep it up!";
  }

  String get sprintLabel => 'Sprint 20 - Burnout Stats';

  double get burnoutProgress => burnoutLevel == BurnoutLevel.poor ? 0.75 : 0.35;

  // ── Actions ──────────────────────────────────────────────
  void addTask(TaskModel task) => _tasks.insert(0, task);

  void goToCreateTask() {
    Get.toNamed(AppRoutes.createTask);
  }

  void goToDetail(TaskModel task) =>
      Get.toNamed(AppRoutes.taskDetail, arguments: task);

  void goToBurnoutStats() => Get.toNamed(AppRoutes.burnoutStats);
}
