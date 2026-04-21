// ─── lib/features/task/views/widgets/task_confirm_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrmanagement/core/constants/app_assets.dart';
import 'package:hrmanagement/core/widgets/custom_button.dart';
import '../../../../core/constants/app_colors.dart';

class TaskConfirmSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  const TaskConfirmSheet({super.key, required this.onConfirm});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TaskConfirmSheet(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _TaskSheet(
      title: 'Create New Task',
      body:
          'Double-check your task details to ensure everything is correct. Do you want to proceed?',
      primaryLabel: 'Yes, Proceed Now',
      secondaryLabel: 'No, Let me check',
      onPrimary: () {
        Navigator.pop(context);
        onConfirm();
      },
      onSecondary: () => Navigator.pop(context),
    );
  }
}

// ─── lib/features/task/views/widgets/task_success_sheet.dart

class TaskSuccessSheet extends StatelessWidget {
  final VoidCallback onViewTasks;
  const TaskSuccessSheet({super.key, required this.onViewTasks});

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onViewTasks,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (_) => TaskSuccessSheet(onViewTasks: onViewTasks),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _TaskSheet(
      title: 'Task Has Been Created!',
      body:
          'Congratulations! Task has been created! view your task in the task management',
      primaryLabel: 'View Task Management',
      onPrimary: onViewTasks,
      showSecondary: false,
    );
  }
}

// ── Shared sheet layout ──────────────────────────────────────
class _TaskSheet extends StatelessWidget {
  final String title;
  final String body;
  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback onPrimary;
  final VoidCallback? onSecondary;
  final bool showSecondary;

  const _TaskSheet({
    required this.title,
    required this.body,
    required this.primaryLabel,
    this.secondaryLabel = 'No, Let me check',
    required this.onPrimary,
    this.onSecondary,
    this.showSecondary = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 28),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Icon badge
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                body,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textHint,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: CustomButton(text: primaryLabel, onPressed: onPrimary),
              ),
              if (showSecondary) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: onSecondary,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1.4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text(secondaryLabel),
                  ),
                ),
              ],
            ],
          ),
        ),

        Positioned(
          top: -38,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SvgPicture.asset(AppAssets.notetext1),
            ),
          ),
        ),
      ],
    );
  }
}
