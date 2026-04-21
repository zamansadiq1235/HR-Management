// ─── lib/controllers/submit_leave_controller.dart ──────────

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../models/leave_model.dart';
import '../widgets/confirm_submit_sheet.dart';
import '../widgets/date_picker.dart';
import '../widgets/selection_bottom_sheet.dart';
import 'leave_summary_controller.dart';

class SubmitLeaveController extends GetxController {
  //  Text controllers ─────────────────────────────────────
  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();

  //  Observables
  final selectedCategory = RxnString();
  final selectedDelegation = RxnString();
  final selectedCountryCode = 'INA'.obs;
  final selectedStartDate = Rxn<DateTime>();
  final selectedEndDate = Rxn<DateTime>();

  //  Options
  final categoryOptions = [
    'Annual Leave/Vacation Leave',
    'Sick Leave',
    'Emergency Leave',
    'Personal Leave',
    'Jury Duty Leave',
    'Maternity/Paternity Leave',
  ];

  final delegationOptions = [
    'Jeane - UX Writer',
    'Alpheas - UI Designer',
    'John - UX Designer',
    'Alicia - Jr Product Manager',
    'Claudia - UI Designer',
    'Option 4',
    'Option 4',
  ];

  final countryCodes = ['INA', 'USA', 'SGP', 'MYS', 'PK'];

  //  Computed
  String get durationLabel {
    if (selectedStartDate.value == null || selectedEndDate.value == null) {
      return 'Select Duration';
    }
    return '${_fmt(selectedStartDate.value!)} - ${_fmt(selectedEndDate.value!)}';
  }

  bool get isFormValid =>
      selectedCategory.value != null &&
      selectedStartDate.value != null &&
      selectedEndDate.value != null &&
      selectedDelegation.value != null;

  //  Pickers ──────────────────────────────────────────────
  Future<void> openCategorySheet(BuildContext context) async {
    final result = await SelectionBottomSheet.show(
      context: context,
      title: 'Select Leave Category',
      subtitle: 'Select Leave category',
      options: categoryOptions,
      initialValue: selectedCategory.value,
    );
    if (result != null) selectedCategory.value = result;
  }

  Future<void> openDelegationSheet(BuildContext context) async {
    final result = await SelectionBottomSheet.show(
      context: context,
      title: 'Select Task Delegation',
      subtitle: 'Select Leave category',
      options: delegationOptions,
      initialValue: selectedDelegation.value,
    );
    if (result != null) selectedDelegation.value = result;
  }

  Future<void> pickDateRange(BuildContext context) async {
    final range = await LeaveDatePickerSheet.show(
      context: context,
      initialStart: selectedStartDate.value,
      initialEnd: selectedEndDate.value,
    );
    if (range != null) {
      selectedStartDate.value = range.start;
      selectedEndDate.value = range.end;
    }
  }

  void pickCountryCode(String? v) {
    if (v != null) selectedCountryCode.value = v;
  }

  //  Submit flow ──────────────────────────────────────────
  void onSubmitTapped(BuildContext context) {
    if (!isFormValid) return;
    ConfirmSubmitSheet.show(context: context, onConfirm: _doSubmit);
  }

  void _doSubmit() {
    final summaryCtrl = Get.find<LeaveSummaryController>();
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    String fmtShort(DateTime d) => '${d.day} ${months[d.month]}';
    String fmtLong(DateTime d) => '${d.day} ${months[d.month]} ${d.year}';

    final days =
        selectedEndDate.value!.difference(selectedStartDate.value!).inDays + 1;

    summaryCtrl.addRecord(
      LeaveRecord(
        submittedDate: fmtLong(DateTime.now()),
        leaveStart: fmtShort(selectedStartDate.value!),
        leaveEnd: fmtShort(selectedEndDate.value!),
        totalDays: days,
        status: LeaveStatus.review,
      ),
    );

    Get.back();
    Get.snackbar(
      'Leave Submitted ✓',
      'Your leave request is now under review.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  String _fmt(DateTime d) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month]} ${d.year}';
  }

  @override
  void onClose() {
    descriptionController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
