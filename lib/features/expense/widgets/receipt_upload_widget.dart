// ─── lib/features/expense/views/widgets/receipt_upload_widget.dart

// ignore_for_file: unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../controllers/submit_expense_controller.dart';

class ReceiptUploadWidget extends StatelessWidget {
  final SubmitExpenseController controller;

  const ReceiptUploadWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final path = controller.receiptPath.value;
      final uploading = controller.isUploading.value;
      final progress = controller.uploadProgress.value;

      // ── State 1: No file picked ───────────────
      if (path == null) {
        return _EmptyUpload(onTap: controller.pickReceipt);
      }

      // ── State 2: Uploading ────────────────────
      if (uploading && progress != null) {
        return _UploadingWidget(
          progress: progress,
          onRemove: controller.removeReceipt,
        );
      }

      // ── State 3: Receipt uploaded ─────────────
      return _ReceiptPreview(onRemove: controller.removeReceipt);
    });
  }
}

// ── Empty upload area ────────────────────────────────────────
class _EmptyUpload extends StatelessWidget {
  final VoidCallback onTap;
  const _EmptyUpload({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 1.5,
            // Dashed effect approximated via decoration
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.upload_rounded,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Upload Claim Document',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Format should be in .pdf .jpeg .png less than 5MB',
              style: TextStyle(fontSize: 11, color: AppColors.textHint),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Uploading progress ───────────────────────────────────────
class _UploadingWidget extends StatelessWidget {
  final double progress;
  final VoidCallback onRemove;

  const _UploadingWidget({required this.progress, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 4,
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Uploading File...',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        // Remove button
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFE53935),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Receipt preview (mock) 

class _ReceiptPreview extends StatelessWidget {
  final VoidCallback onRemove;
  const _ReceiptPreview({required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubmitExpenseController>();
    final path = controller.receiptPath.value!;

    final isImage =
        path.endsWith('.png') ||
        path.endsWith('.jpg') ||
        path.endsWith('.jpeg');

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: isImage
                ? Image.file(
                    File(path),
                    fit: BoxFit.cover,
                  )
                : _PdfView(), // keep design clean
          ),
        ),

        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                color: Color(0xFFE53935),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// ── Mock receipt visual ──────────────────────────────────────
class _MockReceipt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'SHOP NAME',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
            ),
            const Text(
              'Address: Lorem Ipsum, 23-10\nTelp. 11223344',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9, color: Colors.grey),
            ),
            const Divider(height: 10),
            const Text(
              '— CASH RECEIPT —',
              style: TextStyle(fontSize: 9, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            ...[
              ('Lorem', '1.1'),
              ('Ipsum', '2.2'),
              ('Dolor sit amet', '3.3'),
              ('Consectetur', '4.4'),
              ('Adipiscing elit', '5.5'),
            ].map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.$1,
                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                    Text(
                      e.$2,
                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                ),
                Text(
                  '16.5',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PdfView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.picture_as_pdf, size: 50, color: Colors.red),
            SizedBox(height: 8),
            Text("PDF Document"),
          ],
        ),
      ),
    );
  }
}