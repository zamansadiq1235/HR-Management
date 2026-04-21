
class SubmitExpenseModel {
  final String? receiptPath;       // local file path after pick
  final double? uploadProgress;   // 0.0 – 1.0, null = not uploading
  final String? category;
  final DateTime? transactionDate;
  final String amount;
  final String description;

  const SubmitExpenseModel({
    this.receiptPath,
    this.uploadProgress,
    this.category,
    this.transactionDate,
    this.amount = '',
    this.description = '',
  });

  bool get isValid =>
      receiptPath != null &&
      category != null &&
      transactionDate != null &&
      amount.isNotEmpty;

  SubmitExpenseModel copyWith({
    String? receiptPath,
    double? uploadProgress,
    String? category,
    DateTime? transactionDate,
    String? amount,
    String? description,
  }) =>
      SubmitExpenseModel(
        receiptPath: receiptPath ?? this.receiptPath,
        uploadProgress: uploadProgress ?? this.uploadProgress,
        category: category ?? this.category,
        transactionDate: transactionDate ?? this.transactionDate,
        amount: amount ?? this.amount,
        description: description ?? this.description,
      );
}