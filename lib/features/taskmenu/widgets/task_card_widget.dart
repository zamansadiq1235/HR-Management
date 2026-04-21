// ─── lib/features/task/views/widgets/task_card_widget.dart 

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../models/task_model.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onTap;

  const TaskCardWidget({super.key, required this.task, this.onTap});

  static const _red = Color(0xFFE53935);
  static const _green = Color(0xFF00C897);
  static const _orange = Color(0xFFFFA500);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Title row 
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.bolt_rounded,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            //  Status + Priority chips ─────────────
            Row(
              children: [
                _Chip(
                  label: task.status.label,
                  textColor: AppColors.textHint,
                  borderColor: const Color(0xFFDDDDEE),
                  dotColor: _statusColor(task.status),
                  filled: false,
                ),
                const SizedBox(width: 8),
                _Chip(
                  label: task.priority.label,
                  textColor: Colors.white,
                  filled: true,
                  fillColor: _red,
                  icon: Icons.flag_rounded,
                ),
              ],
            ),
            const SizedBox(height: 12),

            //  Progress bar ────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: task.progress,
                backgroundColor: AppColors.primarySurface,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 5,
              ),
            ),
            const SizedBox(height: 12),

            //  Bottom row ──────────────────────────
            Row(
              children: [
                _AvatarRow(count: task.memberAvatars.length),
                const Spacer(),
                const Icon(Icons.calendar_today_rounded,
                    size: 13, color: AppColors.textHint),
                const SizedBox(width: 4),
                Text(
                  task.createdDate,
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textHint),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.chat_bubble_outline_rounded,
                    size: 13, color: AppColors.textHint),
                const SizedBox(width: 4),
                Text(
                  '${task.commentCount}',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textHint),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(TaskStatus s) {
    switch (s) {
      case TaskStatus.toDo: return AppColors.primary;
      case TaskStatus.inProgress: return _orange;
      case TaskStatus.done: return _green;
    }
  }
}

//  Chip ────────────────────────────────────────────────────
class _Chip extends StatelessWidget {
  final String label;
  final Color textColor;
  final bool filled;
  final Color? fillColor;
  final Color? borderColor;
  final Color? dotColor;
  final IconData? icon;

  const _Chip({
    required this.label,
    required this.textColor,
    required this.filled,
    this.fillColor,
    this.borderColor,
    this.dotColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: filled ? fillColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: filled
            ? null
            : Border.all(
                color: borderColor ?? Colors.grey.shade300, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null)
            Container(
              width: 7,
              height: 7,
              margin: const EdgeInsets.only(right: 5),
              decoration:
                  BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
          if (icon != null)
            Icon(icon, size: 10, color: textColor),
          if (icon != null) const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

//  Avatar row ───────────────────────────────────────────────
class _AvatarRow extends StatelessWidget {
  final int count;
  const _AvatarRow({required this.count});

  static const double _size = 26;
  static const double _overlap = 16;

  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox.shrink();
    final width = _size + (count - 1) * _overlap;
    return SizedBox(
      width: width,
      height: _size,
      child: Stack(
        children: List.generate(
          count,
          (i) => Positioned(
            left: i * _overlap,
            child: Container(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFDDE0FF),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: const Icon(Icons.person,
                  size: 13, color: AppColors.primary),
            ),
          ),
        ),
      ),
    );
  }
}