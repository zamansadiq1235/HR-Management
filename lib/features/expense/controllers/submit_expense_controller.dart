// ─── lib/features/expense/controllers/submit_expense_controller.dart

import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../models/expense_model.dart';
import '../widgets/expense_category_sheet.dart';
import '../widgets/expense_sheets.dart';
import 'expense_summary_controller.dart';

class SubmitExpenseController extends GetxController {
  //  Controllers 
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  // ── Observables 
  final receiptPath = RxnString();       // null = no file picked
  final uploadProgress = RxnDouble();    // null = idle, 0-1 = uploading
  final isUploading = false.obs;
  final selectedCategory = RxnString();
  final selectedDate = Rxn<DateTime>();

  // ── Options 
  final categoryOptions = [
    'Business Trip',
    'Office Supplies',
    'Meals and Entertainment',
    'Professional Development',
    'Home Office Expenses',
    'Mileage Reimbursement',
    'Miscellaneous Expenses',
  ];

  // ── Computed 
  bool get isFormValid =>
      receiptPath.value != null &&
      selectedCategory.value != null &&
      selectedDate.value != null &&
      amountController.text.isNotEmpty;

  String get dateLabel {
    if (selectedDate.value == null) return 'Enter Transaction Date';
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final d = selectedDate.value!;
    return '${d.day} ${months[d.month]} ${d.year}';
  }

  String get dateLabelShort {
    if (selectedDate.value == null) return '';
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final d = selectedDate.value!;
    return '${d.day} ${months[d.month]} ${d.year}';
  }

  // ── Receipt picker (simulated) 

  

final ImagePicker _picker = ImagePicker();

Future<void> pickReceipt() async {
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
              final file = await _picker.pickImage(source: ImageSource.camera);
              if (file != null) _setFile(file.path);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Gallery"),
            onTap: () async {
              Get.back();
              final file = await _picker.pickImage(source: ImageSource.gallery);
              if (file != null) _setFile(file.path);
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
                _setFile(result.files.single.path!);
              }
            },
          ),
        ],
      ),
    ),
  );
}

void _setFile(String path) async {
  receiptPath.value = path;

  // keep your SAME upload UI
  isUploading.value = true;
  uploadProgress.value = 0.0;

  for (int i = 1; i <= 10; i++) {
    await Future.delayed(const Duration(milliseconds: 200));
    uploadProgress.value = i / 10.0;
  }

  isUploading.value = false;
  uploadProgress.value = null;
}
  
  void removeReceipt() {
    receiptPath.value = null;
    uploadProgress.value = null;
    isUploading.value = false;
  }

  // ── Category sheet 
  Future<void> openCategorySheet(BuildContext context) async {
    final result = await ExpenseCategorySheet.show(
      context: context,
      options: categoryOptions,
      initialValue: selectedCategory.value,
    );
    if (result != null) selectedCategory.value = result;
  }

  // ── Date picker 
  Future<void> pickDate(BuildContext context) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? today,
      firstDate: DateTime(2020),
      lastDate: today,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) selectedDate.value = picked;
  }

  // ── Submit flow ──────────────────────────────────────────
  void onSubmitTapped(BuildContext context) {
    if (!isFormValid) return;
    ExpenseConfirmSheet.show(
      context: context,
      onConfirm: () => _doSubmit(context),
    );
  }

  void _doSubmit(BuildContext context) {
    final summaryCtrl = Get.find<ExpenseSummaryController>();

    // Format date for display
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final d = selectedDate.value!;
    final displayDate = '${d.day} ${months[d.month]} ${d.year}';

    summaryCtrl.addRecord(ExpenseRecord(
      submittedDate: displayDate,
      type: selectedCategory.value!,
      totalAmount: double.tryParse(amountController.text) ?? 0,
      status: ExpenseStatus.review,
    ));

    Get.back(); // close confirm sheet

    ExpenseSuccessSheet.show(
      context: context,
      onViewHistory: () {
        Get.back(); // close success sheet
        Get.back(); // back to summary
      },
    );
  }

  @override
  void onClose() {
    amountController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}