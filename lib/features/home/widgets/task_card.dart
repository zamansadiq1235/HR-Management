import 'package:flutter/material.dart';
import 'package:hrmanagement/core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.divider,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title row ───────────────────────
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  task.title,
                  style: AppTextStyles.bodyText2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Status chips ────────────────────
          Row(
            children: [
              _Chip(
                label: task.status,
                icon: Icons.circle,
                iconColor: task.status == 'In Progress'
                    ? const Color(0xFF4CAF50)
                    : task.status == 'Pending'
                    ? const Color(0xFFFFC107)
                    : const Color(0xFF9E9E9E),
                textColor: AppColors.textSecondary,
                borderColor: const Color.fromARGB(255, 214, 214, 227),
                fillColor: AppColors.textHint,
                filled: true,
              ),
              const SizedBox(width: 8),
              _Chip(
                label: task.priority,
                icon: Icons.flag_rounded,
                iconColor: Colors.white,
                textColor: Colors.white,
                fillColor: AppColors.highPriority,
                filled: true,
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ── Progress bar ────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: task.progress,
              backgroundColor: AppColors.divider,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
              minHeight: 6,
            ),
          ),

          const SizedBox(height: 14),

          // ── Bottom row ──────────────────────
          Row(
            children: [
              _AvatarRow(count: task.members.length),
              const Spacer(),
              Icon(
                Icons.calendar_today_rounded,
                size: 13,
                color: AppColors.bottomNavInactive,
              ),
              const SizedBox(width: 4),
              Text(
                task.date,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.bottomNavInactive,
                ),
              ),
              const SizedBox(width: 14),
              const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 13,
                color: AppColors.bottomNavInactive,
              ),
              const SizedBox(width: 4),
              Text(
                '${task.comments}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.bottomNavInactive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Chip ───────────────────────────────────────────────────
class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final bool filled;
  final Color? fillColor;
  final Color? borderColor;

  const _Chip({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.textColor,
    required this.filled,
    this.fillColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: filled ? fillColor : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: filled
            ? null
            : Border.all(
                color: borderColor ?? Colors.grey.shade300,
                width: 1.2,
              ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: iconColor),
          const SizedBox(width: 4),
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

// ── Stacked Avatar Row ─────────────────────────────────────
class _AvatarRow extends StatelessWidget {
  final int count;

  const _AvatarRow({required this.count});

  static const double _size = 26;
  static const double _overlap = 16;

  @override
  Widget build(BuildContext context) {
    final width = count > 0 ? _size + (count - 1) * _overlap : 0.0;
    final List<String> dummyAvatars = [
      "assets/images/Ellipse1.png",
      "assets/images/Ellipse.png",
      "assets/images/Ellipse1.png",
    ];
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
              child: Image.asset(
                dummyAvatars[i % dummyAvatars.length],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
