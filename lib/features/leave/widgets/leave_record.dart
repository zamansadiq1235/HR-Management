// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrmanagement/core/constants/app_assets.dart';

import '../../../core/constants/app_colors.dart';
import '../models/leave_model.dart';

class LeaveRecordCard extends StatelessWidget {
  final LeaveRecord record;

  const LeaveRecordCard({required this.record});

  static const Color _textPrimary = Color(0xFF1A1A2E);
  static const Color _textSecondary = Color(0xFF9B9BAD);
  static const Color _green = Color(0xFF00C897);
  static const Color _red = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
          // ── Date header ─────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                record.status == LeaveStatus.review
                    ? Icon(
                        Icons.star_border_rounded,
                        size: 18,
                        color: AppColors.primary,
                      )
                    : SvgPicture.asset(
                        AppAssets.receipt,
                        width: 18,
                        height: 18,
                        color: AppColors.primary,
                      ),
                const SizedBox(width: 8),
                Text(
                  record.submittedDate,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _textPrimary,
                  ),
                ),
              ],
            ),
          ),
          // ── Details row ──────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8FB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEEEEF5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Leave Date',
                        style: TextStyle(fontSize: 10.5, color: _textSecondary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${record.leaveStart} - ${record.leaveEnd}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Total Leave',
                        style: TextStyle(fontSize: 10.5, color: _textSecondary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${record.totalDays} Days',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // ── Status footer ────────────────────────
          if (record.status != LeaveStatus.review &&
              record.approvedOrRejectedAt != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  Icon(
                    record.status == LeaveStatus.approved
                        ? Icons.check_circle_rounded
                        : Icons.cancel_rounded,
                    size: 15,
                    color: record.status == LeaveStatus.approved
                        ? _green
                        : _red,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${record.status == LeaveStatus.approved ? 'Approved' : 'Rejected'} at ${record.approvedOrRejectedAt}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: record.status == LeaveStatus.approved
                          ? _green
                          : _red,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'By ',
                    style: TextStyle(fontSize: 12, color: _textSecondary),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFDDE0FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 12,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    record.approvedOrRejectedBy ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _textPrimary,
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(height: 16),
        ],
      ),
    );
  }
}
