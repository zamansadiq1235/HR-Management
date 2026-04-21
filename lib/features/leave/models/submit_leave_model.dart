// ─── lib/models/submit_leave_model.dart ────────────────────

class SubmitLeaveModel {
  final String? category;
  final String? durationStart;
  final String? durationEnd;
  final String? taskDelegation;
  final String phoneCountryCode;
  final String phoneNumber;
  final String description;

  const SubmitLeaveModel({
    this.category,
    this.durationStart,
    this.durationEnd,
    this.taskDelegation,
    this.phoneCountryCode = 'INA',
    this.phoneNumber = '',
    this.description = '',
  });

  SubmitLeaveModel copyWith({
    String? category,
    String? durationStart,
    String? durationEnd,
    String? taskDelegation,
    String? phoneCountryCode,
    String? phoneNumber,
    String? description,
  }) {
    return SubmitLeaveModel(
      category: category ?? this.category,
      durationStart: durationStart ?? this.durationStart,
      durationEnd: durationEnd ?? this.durationEnd,
      taskDelegation: taskDelegation ?? this.taskDelegation,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      description: description ?? this.description,
    );
  }

  bool get isValid =>
      category != null &&
      durationStart != null &&
      durationEnd != null &&
      taskDelegation != null &&
      phoneNumber.isNotEmpty;
}
