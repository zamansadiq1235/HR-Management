// ─── lib/views/submit_leave_screen.dart ────────────────────

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controller/submit_leave_controller.dart';
import '../widgets/leave_date_field.dart';
import '../widgets/leave_description_field.dart';
import '../widgets/leave_dropdown_field.dart';
import '../widgets/leave_phone_field.dart';

class SubmitLeaveScreen extends StatelessWidget {
  SubmitLeaveScreen({super.key});

  final SubmitLeaveController _c = Get.put(SubmitLeaveController());

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
              const Text(
                'Fill Leave Information',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Information about leave details',
                style: TextStyle(fontSize: 12, color: AppColors.textHint),
              ),
              const SizedBox(height: 24),

              _Label('Leave Category'),
              const SizedBox(height: 8),
              Obx(
                () => LeaveDropdownField(
                  icon: Icons.badge_rounded,
                  hintText: 'Select Category',
                  value: _c.selectedCategory.value,
                  onTap: () => _c.openCategorySheet(context),
                ),
              ),
              const SizedBox(height: 18),

              _Label('Leave Duration'),
              const SizedBox(height: 8),
              Obx(
                () => LeaveDateField(
                  text: _c.durationLabel,
                  isEmpty: _c.selectedStartDate.value == null,
                  onTap: () => _c.pickDateRange(context),
                ),
              ),
              const SizedBox(height: 18),

              _Label('Task Delegation'),
              const SizedBox(height: 8),
              Obx(
                () => LeaveDropdownField(
                  icon: Icons.person_outline_rounded,
                  hintText: 'Select Category',
                  value: _c.selectedDelegation.value,
                  onTap: () => _c.openDelegationSheet(context),
                ),
              ),
              const SizedBox(height: 18),

              _Label('Emergency Contact During Leave Period'),
              const SizedBox(height: 8),
              LeavePhoneField(controller: _c),
              const SizedBox(height: 18),

              _Label('Leave Description'),
              const SizedBox(height: 8),
              DescriptionField(
                hint: 'Enter Leave Description',
                controller: _c.descriptionController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildSubmitButton(context),
    );
  }

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
            size: 22,
          ),
        ),
      ),
      title: const Text(
        'Submit Leave',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      child: Obx(() {
        final valid = _c.isFormValid;
        return SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: valid ? () => _c.onSubmitTapped(context) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: valid
                  ? AppColors.primary
                  : AppColors.primarySurface,
              foregroundColor: valid ? Colors.white : AppColors.primary,
              disabledBackgroundColor: AppColors.primarySurface,
              disabledForegroundColor: AppColors.primary.withOpacity(0.5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            child: const Text('Submit Now'),
          ),
        );
      }),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
        color: AppColors.textHint,
      ),
    );
  }
}
