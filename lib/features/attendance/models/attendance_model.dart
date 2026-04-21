// ─── lib/features/attendance/models/attendance_model.dart ───

class AttendanceModel {
  final String date;
  final String totalHours;
  final String clockIn;
  final String clockOut;
  final String breakHours;
  final String takeABreak;
  final String backToWork;
  final String? selfieImagePath;
  final String lat;
  final String lng;
  final String clockInNotes;

  const AttendanceModel({
    required this.date,
    required this.totalHours,
    required this.clockIn,
    required this.clockOut,
    this.breakHours = '01:00:00 hrs',
    this.takeABreak = '12:00 AM',
    this.backToWork = '01:00 PM',
    this.selfieImagePath,
    this.lat = '45.43534',
    this.lng = '97897.576',
    this.clockInNotes = '',
  });
}