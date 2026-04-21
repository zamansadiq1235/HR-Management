import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../models/task_model.dart';
import '../widgets/task_selection_sheet.dart';
import '../widgets/task_sheets.dart';
import 'task_menu_controller.dart';

class _AttachmentSlot {
  double? progress; // null = empty, 0-1 = uploading, 1 = done
  String? path;

  _AttachmentSlot({this.progress, this.path});
}

class CreateTaskController extends GetxController {
  // ── Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // ── Reactive State
  final slots = List.generate(3, (_) => _AttachmentSlot()).obs;

  final selectedAssignee = RxnString();
  final selectedPriority = RxnString();
  final selectedDifficulty = RxnString();

  final isFormValid = false.obs;

  final ImagePicker _picker = ImagePicker();

  // ── Options
  final assigneeOptions = [
    'Ivankov - Sr Front End Developer',
    'Brahm - Mid Front End Developer',
    'Alice - Sr Front End Developer',
    'Jeane - Jr Front End Developer',
    'Claudia - Jr Front End Developer',
  ];

  final priorityOptions = ['Low', 'Medium', 'High'];

  final difficultyOptions = [
    'Very Easy (Less Than a Day)',
    'Easy (A Day)',
    'Moderate (3 Days)',
    'Intermediate (5 Days)',
    'Advanced (1 Week)',
  ];

  // ── Lifecycle
  @override
  void onInit() {
    super.onInit();

    titleController.addListener(validateForm);

    ever(selectedAssignee, (_) => validateForm());
    ever(selectedPriority, (_) => validateForm());
    ever(selectedDifficulty, (_) => validateForm());
  }

  // ── Validation
  void validateForm() {
    isFormValid.value =
        titleController.text.isNotEmpty &&
        selectedAssignee.value != null &&
        selectedPriority.value != null &&
        selectedDifficulty.value != null &&
        slots.any((s) => s.path != null);
  }

  // ── PICK ATTACHMENT (REAL)
  Future<void> pickAttachment(int index) async {
    if (slots[index].path != null) return;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Get.back();
                final file = await _picker.pickImage(
                  source: ImageSource.camera,
                );
                if (file != null) _setFile(index, file.path);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () async {
                Get.back();
                final file = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (file != null) _setFile(index, file.path);
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: const Text("Document"),
              onTap: () async {
                Get.back();
                final result = await FilePicker.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
                );
                if (result != null) {
                  _setFile(index, result.files.single.path!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── HANDLE FILE + FAKE UPLOAD
  void _setFile(int index, String path) async {
    slots[index] = _AttachmentSlot(progress: 0.0);
    slots.refresh();

    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      slots[index] = _AttachmentSlot(progress: i / 10);
      slots.refresh();
    }

    slots[index] = _AttachmentSlot(progress: 1, path: path);
    slots.refresh();

    validateForm();
  }

  void removeAttachment(int index) {
    slots[index] = _AttachmentSlot();
    slots.refresh();
    validateForm();
  }

  // ── Sheets
  Future<void> openAssigneeSheet(BuildContext context) async {
    final result = await TaskSelectionSheet.show(
      context: context,
      title: 'Assign To',
      subtitle: 'Who will finish this task',
      options: assigneeOptions,
      initialValue: selectedAssignee.value,
    );
    if (result != null) selectedAssignee.value = result;
  }

  Future<void> openPrioritySheet(BuildContext context) async {
    final result = await TaskSelectionSheet.show(
      context: context,
      title: 'Priority',
      subtitle: 'Select priority',
      options: priorityOptions,
      initialValue: selectedPriority.value,
    );
    if (result != null) selectedPriority.value = result;
  }

  Future<void> openDifficultySheet(BuildContext context) async {
    final result = await TaskSelectionSheet.show(
      context: context,
      title: 'Difficulty',
      subtitle: 'Select difficulty',
      options: difficultyOptions,
      initialValue: selectedDifficulty.value,
    );
    if (result != null) selectedDifficulty.value = result;
  }

  // ── Submit
  void onCreateTapped(BuildContext context) {
    if (!isFormValid.value) return;

    TaskConfirmSheet.show(
      context: context,
      onConfirm: () => _createTask(context),
    );
  }

  void _createTask(BuildContext context) {
    final menuCtrl = Get.find<TaskMenuController>();

    final parts = (selectedAssignee.value ?? '').split(' - ');
    final name = parts.isNotEmpty ? parts[0] : '';
    final role = parts.length > 1 ? parts[1] : '';

    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      description: descriptionController.text,
      assignee: name,
      assigneeRole: role,
      priority: TaskPriority.medium,
      difficulty: TaskDifficulty.easy,
      status: TaskStatus.toDo,
      createdDate: 'Today',
      memberAvatars: ['a'],
      commentCount: 0,
      progress: 0.0,
    );

    menuCtrl.addTask(task);

    Get.back();

    TaskSuccessSheet.show(
      context: context,
      onViewTasks: () {
        Get.back();
        Get.back();
      },
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
