import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/meeting_model.dart';
import '../models/task_model.dart';

class HomeController extends GetxController {
  final RxList<MeetingModel> meetings = <MeetingModel>[
    MeetingModel(
      title: "Townhall Meeting",
      time: "01:30 AM - 02:00 AM",
      members: ["a", "b", "c"],
      extraMemberCount: 3,
    ),
    MeetingModel(
      title: "Dashboard Report",
      time: "01:30 AM - 02:00 AM",
      members: ["a", "b", "c"],
    ),
  ].obs;

  final RxList<TaskModel> tasks = <TaskModel>[
    TaskModel(
      title: "Wiring Dashboard Analytics",
      status: "In Progress",
      priority: "High",
      date: "27 April",
      comments: 2,
      progress: 0.65,
      members: ["a", "b", "c"],
    ),
  ].obs;

  int get meetingCount => meetings.length;
  int get taskCount => tasks.length;

  void joinMeeting(MeetingModel meeting) {
    Get.snackbar(
      'Joining',
      meeting.title,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6C5CE7),
      colorText: Colors.white,
    );
  }
}
