// ─── lib/features/expense/views/submit_expense_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../leave/widgets/leave_description_field.dart';
import '../controllers/submit_expense_controller.dart';
import '../widgets/receipt_upload_widget.dart';

class SubmitExpenseScreen extends StatelessWidget {
  SubmitExpenseScreen({super.key});

  final SubmitExpenseController _c = Get.put(SubmitExpenseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Promo banner
            _PromoBanner(),
            const SizedBox(height: 16),
            //  Form card
            Container(
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
                    'Fill Claim Information',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Information about claim details',
                    style: TextStyle(fontSize: 12, color: AppColors.textHint),
                  ),
                  const SizedBox(height: 20),

                  // Receipt upload
                  ReceiptUploadWidget(controller: _c),
                  const SizedBox(height: 20),

                  // Expense Category
                  _FieldLabel('Expense Category'),
                  const SizedBox(height: 8),
                  Obx(
                    () => _DropdownTile(
                      icon: Icons.badge_rounded,
                      value: _c.selectedCategory.value,
                      hint: 'Select Category',
                      onTap: () => _c.openCategorySheet(context),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Transaction Date
                  _FieldLabel('Transaction Date'),
                  const SizedBox(height: 8),
                  Obx(
                    () => _DropdownTile(
                      icon: Icons.calendar_month_rounded,
                      value: _c.selectedDate.value != null
                          ? _c.dateLabel
                          : null,
                      hint: 'Enter Transaction Date',
                      onTap: () => _c.pickDate(context),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Amount
                  _FieldLabel('Expense Amount (\$USD)'),
                  const SizedBox(height: 8),
                  _AmountField(controller: _c),
                  const SizedBox(height: 16),

                  // Description
                  _FieldLabel('Expense Description'),
                  const SizedBox(height: 8),
                  DescriptionField(
                    hint: 'Enter Expense Description',
                    controller: _c.descriptionController,
                  ),
                ],
              ),
            ),
          ],
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
        'Submit Expense',
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
              disabledBackgroundColor: AppColors.primarySurface,
              foregroundColor: valid ? Colors.white : AppColors.primary,
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
            child: const Text('Submit Expense'),
          ),
        );
      }),
    );
  }
}

//  Promo Banner
class _PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 129,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('assets/images/banner.png'),
          fit: BoxFit.cover,
        ),
      ),
      
    );
  }
}

//  Dropdown tile
class _DropdownTile extends StatelessWidget {
  final IconData icon;
  final String? value;
  final String hint;
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
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primary, size: 17),
            ),
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

//  Amount field
class _AmountField extends StatelessWidget {
  final SubmitExpenseController controller;
  const _AmountField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8F0), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.attach_money_rounded,
              color: AppColors.primary,
              size: 17,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller.amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: const TextStyle(
                fontSize: 13.5,
                color: AppColors.textPrimary,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: 'Enter Amount',
                hintStyle: TextStyle(color: AppColors.textHint, fontSize: 13.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  Description field

//  Field label
class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }
}
