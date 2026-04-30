// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  static const _red = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    // Get.arguments کے ذریعے ڈیٹا وصول کرنا
    final task = Get.arguments as TaskModel;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_left_rounded,
              color: AppColors.primary,
              size: 22,
            ),
          ),
        ),
        title: const Text(
          'Task Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title & Status ────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        task.status.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                child: Text(
                  'Created ${task.createdDate}',
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              // ── Main Image (Shows first attachment if available) ──
              if (task.attachments.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: const Color(0xFFEEEBFF),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: (File(task.attachments.first).existsSync())
                            ? Image.file(
                                File(task.attachments.first),
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ), // اگر فائل نہ ملے
                      ),
                    ),
                  ),
                ),

              // ── Thumbnail Row (All attachments) ──
              if (task.attachments.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: task.attachments.map((path) {
                        final isPdf = path.endsWith('.pdf');
                        final fileExists = File(path).existsSync();

                        return GestureDetector(
                          onTap: () {
                            if (fileExists) {
                              //  Implement file preview/download
                            }
                          },
                          child: Container(
                            width: 68,
                            height: 56,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDDE0FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: isPdf
                                  ? const Center(
                                      child: Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                        size: 28,
                                      ),
                                    )
                                  : fileExists
                                  ? Image.file(
                                      File(path),
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Center(
                                            child: Icon(
                                              Icons.broken_image,
                                              color: Colors.grey,
                                              size: 24,
                                            ),
                                          ),
                                    )
                                  : const Center(
                                      child: Icon(
                                        Icons.file_present,
                                        color: Colors.grey,
                                        size: 24,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

              // ── Description ───────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFEEEEF5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        task.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Priority & Difficulty ─────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
                child: Row(
                  children: [
                    // Priority
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Priority',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: _red,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.flag_rounded,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  task.priority.label,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Difficulty
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Difficulty',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text(
                                _getDifficultyEmoji(task.difficulty.label),
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  task.difficulty.label,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Assignee ──────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Assignee',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDDE0FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.assignee,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              task.assigneeRole,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, color: Color(0xFFEEEEF5)),

              // ── Modified Comment Section ──────────
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Sample Comment (آپ یہاں اپنی کمنٹس کی لسٹ میپ کر سکتے ہیں)
                    _buildCommentItem(
                      name: "Admin",
                      message: "Please complete this task by tomorrow.",
                      time: "2h ago",
                    ),

                    const SizedBox(height: 20),

                    // Comment Input Field
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Color(0xFFDDE0FF),
                          child: Icon(
                            Icons.person,
                            size: 20,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F6FA),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Write a comment...',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textPrimary,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for comment items
  Widget _buildCommentItem({
    required String name,
    required String message,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 16,
          backgroundColor: Color(0xFFEEEEF5),
          child: Icon(Icons.person, size: 18, color: Colors.grey),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper for difficulty emojis
  String _getDifficultyEmoji(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return '😊';
      case 'medium':
        return '😐';
      case 'hard':
        return '🔥';
      default:
        return '✨';
    }
  }
}
