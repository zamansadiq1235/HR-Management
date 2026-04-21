// ─── lib/models/leave_model.dart ───────────────────────────

enum LeaveStatus { review, approved, rejected }

class LeaveRecord {
  final String submittedDate;   // e.g. "10 November 2024"
  final String leaveStart;      // e.g. "11 Nov"
  final String leaveEnd;        // e.g. "13 Nov"
  final int totalDays;
  final LeaveStatus status;
  final String? approvedOrRejectedAt; // e.g. "19 Sept 2024"
  final String? approvedOrRejectedBy; // e.g. "Elaine"

  const LeaveRecord({
    required this.submittedDate,
    required this.leaveStart,
    required this.leaveEnd,
    required this.totalDays,
    required this.status,
    this.approvedOrRejectedAt,
    this.approvedOrRejectedBy,
  });
}
