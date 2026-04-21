// ─── lib/features/expense/bindings/expense_binding.dart ────

import 'package:get/get.dart';
import '../controllers/expense_summary_controller.dart';
import '../controllers/submit_expense_controller.dart';

class ExpenseSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseSummaryController>(() => ExpenseSummaryController());
  }
}

class SubmitExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitExpenseController>(() => SubmitExpenseController());
  }
}