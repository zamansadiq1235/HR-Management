// ─── lib/controllers/leave_summary_controller.dart ─────────

import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../models/leave_model.dart';

class LeaveSummaryController extends GetxController {
  // ── Leave balance ───────────────────────────────────────
  final totalAvailable = 20.obs;
  final leaveUsed = 2.obs;
  final periodStart = 'Period 1 Jan 2024'.obs;
  final periodEnd = '30 Dec 2024'.obs;

  // ── Tab ─────────────────────────────────────────────────
  final selectedTab = LeaveStatus.review.obs;

  void selectTab(LeaveStatus status) => selectedTab.value = status;

  // ── Leave records ────────────────────────────────────────
  final _allRecords = <LeaveRecord>[
    LeaveRecord(
      submittedDate: '10 November 2024',
      leaveStart: '11 Nov',
      leaveEnd: '13 Nov',
      totalDays: 2,
      status: LeaveStatus.review,
    ),
    LeaveRecord(
      submittedDate: '18 September 2024',
      leaveStart: '20 Sept',
      leaveEnd: '22 Sept',
      totalDays: 2,
      status: LeaveStatus.approved,
      approvedOrRejectedAt: '19 Sept 2024',
      approvedOrRejectedBy: 'Elaine',
    ),
    LeaveRecord(
      submittedDate: '21 September 2024',
      leaveStart: '10 Nov',
      leaveEnd: '17 Nov',
      totalDays: 7,
      status: LeaveStatus.rejected,
      approvedOrRejectedAt: '22 Sept 2024',
      approvedOrRejectedBy: 'Elaine',
    ),
  ].obs;

  List<LeaveRecord> get filteredRecords =>
      _allRecords.where((r) => r.status == selectedTab.value).toList();

  int get reviewCount =>
      _allRecords.where((r) => r.status == LeaveStatus.review).length;

  void goToSubmitLeave() => Get.toNamed(AppRoutes.submitLeave);

  void addRecord(LeaveRecord record) {
    _allRecords.add(record);
    leaveUsed.value += 1;
  }
}
