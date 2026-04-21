// ─── lib/features/task/bindings/task_binding.dart ──────────

import 'package:get/get.dart';
import '../controllers/task_menu_controller.dart';
import '../controllers/create_task_controller.dart';

class TaskMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskMenuController>(() => TaskMenuController());
  }
}

class CreateTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTaskController>(() => CreateTaskController());
  }
}