class MeetingModel {
  final String title;
  final String time;
  final List<String> members;
  final int extraMemberCount;

  MeetingModel({
    required this.title,
    required this.time,
    required this.members,
    this.extraMemberCount = 0,
  });
}
