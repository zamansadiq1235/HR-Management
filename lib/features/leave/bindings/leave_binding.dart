// ─── lib/bindings/leave_binding.dart ───────────────────────

import 'package:get/get.dart';

import '../controller/leave_summary_controller.dart';
import '../controller/submit_leave_controller.dart';

class LeaveSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveSummaryController>(() => LeaveSummaryController());
  }
}

class SubmitLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitLeaveController>(() => SubmitLeaveController());
  }
}
