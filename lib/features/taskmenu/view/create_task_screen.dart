// ignore_for_file: deprecated_member_use, public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hrmanagement/core/widgets/custom_textfield.dart';
import 'package:hrmanagement/features/leave/widgets/leave_description_field.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/create_task_controller.dart';

class CreateTaskScreen extends StatelessWidget {
  CreateTaskScreen({super.key});

  final CreateTaskController _c = Get.put(CreateTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        child: Container(
          padding: const EdgeInsets.all(20),
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
              /// ── Attachment
              const Text(
                'Attachment',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Format should be in .pdf .jpeg .png less than 5MB',
                style: TextStyle(fontSize: 12, color: AppColors.textHint),
              ),
              const SizedBox(height: 14),
              _AttachmentRow(controller: _c),

              const SizedBox(height: 20),

              /// ── Title
              const SizedBox(height: 8),
              CustomTextfield(
                controller: _c.titleController,
                label: 'Task Title',
                hintText: 'Enter task tile',
                isPassword: false,
                obscureText: false,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: SvgPicture.asset(
                    AppAssets.receipt1,
                    color: AppColors.primary,
                  ),
                ),
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: 16),

              /// ── Description
              const _FieldLabel('Task Description'),
              const SizedBox(height: 8),
              DescriptionField(
                controller: _c.descriptionController,
                hint: 'Enter Task Description',
              ),

              const SizedBox(height: 16),

              /// ── Assign
              const _FieldLabel('Assign To'),
              const SizedBox(height: 8),
              Obx(
                () => _DropdownTile(
                  icon: SvgPicture.asset(
                    AppAssets.useroctagonfilled,
                    color: AppColors.primary,
                    height: 22,
                    width: 22,
                  ),
                  hint: 'Select Member',
                  value: _c.selectedAssignee.value,
                  onTap: () => _c.openAssigneeSheet(context),
                ),
              ),

              const SizedBox(height: 16),

              /// ── Priority
              const _FieldLabel('Priority'),
              const SizedBox(height: 8),
              Obx(
                () => _DropdownTile(
                  icon: SvgPicture.asset(
                    AppAssets.layer,
                    color: AppColors.primary,
                    height: 20,
                    width: 20,
                  ),
                  hint: 'Select Priority',
                  value: _c.selectedPriority.value,
                  onTap: () => _c.openPrioritySheet(context),
                ),
              ),

              const SizedBox(height: 16),

              /// ── Difficulty
              const _FieldLabel('Difficulty'),
              const SizedBox(height: 8),
              Obx(
                () => _DropdownTile(
                  icon: Icon(Icons.circle, color: AppColors.primary),
                  hint: 'Select Difficulty',
                  value: _c.selectedDifficulty.value,
                  onTap: () => _c.openDifficultySheet(context),
                ),
              ),
            ],
          ),
        ),
      ),

      /// FIXED BUTTON
      bottomNavigationBar: Obx(() {
        final valid = _c.isFormValid.value;

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: valid ? () => _c.onCreateTapped(context) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: valid
                    ? AppColors.primary
                    : AppColors.primarySurface,
                disabledBackgroundColor: AppColors.primarySurface,
                foregroundColor: valid ? Colors.white : AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Create Task',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// ── AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.primary,
          ),
        ),
      ),
      title: const Text(
        'Create New Task',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

// ── Attachment Row (3 slots) ─────────────────────────────────
class _AttachmentRow extends StatelessWidget {
  final CreateTaskController controller;
  const _AttachmentRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(3, (i) {
          final slot = controller.slots[i];
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < 2 ? 10 : 0),
              child: _AttachmentSlotWidget(
                slot: slot,
                onTap: () => controller.pickAttachment(i),
                onRemove: () => controller.removeAttachment(i),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _AttachmentSlotWidget extends StatelessWidget {
  final dynamic slot; // _AttachmentSlot
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _AttachmentSlotWidget({
    required this.slot,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Empty slot
    if (slot.path == null && slot.progress == null) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1.2,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.upload_rounded,
              color: AppColors.primary,
              size: 26,
            ),
          ),
        ),
      );
    }

    // Uploading slot

    if (slot.progress != null && slot.progress >= 0 && slot.path == null) {
      return Stack(
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
                width: 1.2,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: slot.progress,
                          strokeWidth: 3,
                          backgroundColor: AppColors.primary.withOpacity(0.15),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                        Text(
                          '${(slot.progress * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Uploading...',
                    style: TextStyle(fontSize: 9, color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Color(0xFFE53935),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  size: 11,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Done slot — show mock image preview
    final isImage =
        slot.path.endsWith('.pdf') ||
        slot.path.endsWith('.png') ||
        slot.path.endsWith('.jpg') ||
        slot.path.endsWith('.jpeg');
    return Stack(
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: const Color(0xFFDDE0FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: isImage
                ? Image.file(File(slot.path), fit: BoxFit.cover)
                : const Icon(Icons.picture_as_pdf, color: Colors.red),
          ),
        ),

        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Color(0xFFE53935),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 11,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Reusable form widgets ────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 12.5,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
  );
}

class _DropdownTile extends StatelessWidget {
  final Widget icon;
  final String hint;
  final String? value;
  final VoidCallback onTap;

  const _DropdownTile({
    required this.icon,
    required this.hint,
    required this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE8E8F0), width: 1.2),
        ),
        child: Row(
          children: [
            icon,
            // Icon(i, color: AppColors.primary, size: 17),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                hasValue ? value! : hint,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: hasValue ? FontWeight.w500 : FontWeight.w400,
                  color: hasValue ? AppColors.textPrimary : AppColors.textHint,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textHint,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
