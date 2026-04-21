
import 'package:get/get.dart';
import 'package:hrmanagement/core/routes/app_routes.dart';
import '../models/expense_model.dart';

class ExpenseSummaryController extends GetxController {
  //  Period 
  final period = 'Period 1 Jan 2024 - 30 Dec 2024'.obs;

  //  Tab 
  final selectedTab = ExpenseStatus.review.obs;
  void selectTab(ExpenseStatus s) => selectedTab.value = s;

  //  Records 
  final _records = <ExpenseRecord>[
    ExpenseRecord(
      submittedDate: '27 September 2024',
      type: 'E-Learning',
      totalAmount: 55,
      status: ExpenseStatus.review,
    ),
    ExpenseRecord(
      submittedDate: '24 September 2024',
      type: 'E-Learning',
      totalAmount: 55,
      status: ExpenseStatus.review,
    ),
    ExpenseRecord(
      submittedDate: '21 September 2024',
      type: 'E-Learning',
      totalAmount: 55,
      status: ExpenseStatus.review,
    ),
    ExpenseRecord(
      submittedDate: '18 September 2024',
      type: 'E-Learning',
      totalAmount: 55,
      status: ExpenseStatus.approved,
      actionDate: '19 Sept 2024',
      actionBy: 'Elaine',
    ),
    ExpenseRecord(
      submittedDate: '14 September 2024',
      type: 'E-Learning',
      totalAmount: 55,
      status: ExpenseStatus.approved,
      actionDate: '19 Sept 2024',
      actionBy: 'Elaine',
    ),
    ExpenseRecord(
      submittedDate: '27 September 2024',
      type: 'Business Trip',
      totalAmount: 100,
      status: ExpenseStatus.rejected,
      actionDate: '28 Sept 2024',
      actionBy: 'Elaine',
    ),
    ExpenseRecord(
      submittedDate: '24 September 2024',
      type: 'Business Trip',
      totalAmount: 100,
      status: ExpenseStatus.rejected,
      actionDate: '28 Sept 2024',
      actionBy: 'Elaine',
    ),
  ].obs;

  //  Computed balances 
  double get totalExpense => _records.fold(0, (s, r) => s + r.totalAmount);

  double get reviewTotal => _records
      .where((r) => r.status == ExpenseStatus.review)
      .fold(0, (s, r) => s + r.totalAmount);

  double get approvedTotal => _records
      .where((r) => r.status == ExpenseStatus.approved)
      .fold(0, (s, r) => s + r.totalAmount);

  //  Tab counts 
  int countOf(ExpenseStatus s) => _records.where((r) => r.status == s).length;

  //  Filtered list 
  List<ExpenseRecord> get filteredRecords =>
      _records.where((r) => r.status == selectedTab.value).toList();

  //  Actions 
  void addRecord(ExpenseRecord record) {
    _records.insert(0, record);
  }

  void goToSubmitExpense() => Get.toNamed(AppRoutes.submitExpense);
}
