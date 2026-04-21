// ─── lib/features/expense/models/expense_model.dart ────────

enum ExpenseStatus { review, approved, rejected }

class ExpenseRecord {
  final String submittedDate;      // e.g. "27 September 2024"
  final String type;               // e.g. "E-Learning", "Business Trip"
  final double totalAmount;        // e.g. 55.0
  final ExpenseStatus status;
  final String? actionDate;        // e.g. "19 Sept 2024"
  final String? actionBy;         // e.g. "Elaine"

  const ExpenseRecord({
    required this.submittedDate,
    required this.type,
    required this.totalAmount,
    required this.status,
    this.actionDate,
    this.actionBy,
  });
}