import 'package:get/get.dart';
import 'package:hrmanagement/features/attendance/view/clock_in_area_screen.dart';
import 'package:hrmanagement/features/notification/view/notification_screen.dart';
import '../../features/attendance/bindings/attendance_binding.dart';
import '../../features/attendance/view/attendance_detail.dart';
import '../../features/attendance/view/attendance_screen.dart';
import '../../features/attendance/view/selfie_clockin_screen.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/auth/views/email_verification_view.dart';
import '../../features/auth/views/forgot_password_view.dart';
import '../../features/auth/views/phone_verification_view.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/auth/views/sign_up_view.dart';
import '../../features/auth/views/welcome_view.dart';
import '../../features/auth/views/terms_view.dart';
import '../../features/expense/binding/expense_binding.dart';
import '../../features/expense/view/expense_summary_screen.dart';
import '../../features/expense/view/submit_expense_screen.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/leave/view/leave_summary_screen.dart';
import '../../features/leave/view/submit_leave_screen.dart';
import '../../features/navbar/bindings/navbar_binding.dart';
import '../../features/navbar/view/navbar_screen.dart';
import '../../features/notification/binding/notification_binding.dart';
import '../../features/onboarding/bindings/onboarding_binding.dart';
import '../../features/onboarding/views/onboarding_view.dart';
import '../../features/profile/binding/profile_binding.dart';
import '../../features/profile/views/change_password_screen.dart';
import '../../features/profile/views/office_assets.dart';
import '../../features/profile/views/payroll_screen.dart';
import '../../features/profile/views/personal_data.dart';
import '../../features/profile/views/profile_screen.dart';
import '../../features/taskmenu/bindings/task_binding.dart';
import '../../features/taskmenu/view/create_task_screen.dart';
import '../../features/taskmenu/view/task_detail_burnout_screens.dart';
import '../../features/taskmenu/view/task_details_screen.dart';
import '../../features/taskmenu/view/task_menu_screen.dart';
import 'app_routes.dart';
import '../../features/home/view/home_view.dart';

class AppPages {
  AppPages._();

  static const onboarding = AppRoutes.onboarding;
  static const home = AppRoutes.home;
  static const signIn = AppRoutes.signIn;
  static const signUp = AppRoutes.signUp;
  static const forgotPassword = AppRoutes.forgotPassword;
  static const emailVerification = AppRoutes.emailVerification;
  static const welcome = AppRoutes.welcome;
  static const terms = AppRoutes.terms;
  static const phoneVerification = AppRoutes.phoneVerification;
  static const navBar = AppRoutes.navBar;
  static const profile = AppRoutes.profile;
  static const submitLeave = AppRoutes.submitLeave;
  static const leaveSummary = AppRoutes.leaveSummary;
  static const expenseSummary = AppRoutes.expenseSummary;
  static const submitExpense = AppRoutes.submitExpense;
  static const taskMenu = AppRoutes.taskMenu;
  static const createTask = AppRoutes.createTask;
  static const taskDetail = AppRoutes.taskDetail;
  static const burnoutStats = AppRoutes.burnoutStats;
  static const clockinArea = AppRoutes.clockinArea;
  static const selfieClockin = AppRoutes.selfieClockin;
  static const attendanceDtail = AppRoutes.attendanceDetail;
  static const notification = AppRoutes.notification;

  static final routes = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => SignInView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.emailVerification,
      page: () => const EmailVerificationView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.terms,
      page: () => const TermsView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.phoneVerification,
      page: () => const PhoneVerificationView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.navBar,
      page: () => BottomNavBar(),
      binding: NavBarItemBinding(),
    ),
    GetPage(
      name: AppRoutes.submitLeave,
      page: () => SubmitLeaveScreen(),
      // binding: NavBarItemBinding(),
    ),
    GetPage(
      name: AppRoutes.leaveSummary,
      page: () => LeaveSummaryScreen(),
      // binding: NavBarItemBinding(),
    ),
    GetPage(
      name: AppRoutes.expenseSummary,
      page: () => ExpenseSummaryScreen(),
      binding: ExpenseSummaryBinding(),
    ),
    GetPage(
      name: AppRoutes.submitExpense,
      page: () => SubmitExpenseScreen(),
      binding: SubmitExpenseBinding(),
    ),
    // task screen
    GetPage(
      name: AppRoutes.taskMenu,
      page: () => TaskMenuScreen(),
      binding: TaskMenuBinding(),
    ),
    GetPage(
      name: AppRoutes.createTask,
      page: () => CreateTaskScreen(),
      binding: CreateTaskBinding(),
    ),
    GetPage(name: AppRoutes.taskDetail, page: () => const TaskDetailScreen()),
    GetPage(
      name: AppRoutes.burnoutStats,
      page: () => const BurnoutStatsScreen(),
    ),
    GetPage(
      name: AppRoutes.attendance, // '/attendance'
      page: () => ClockInScreen(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: AppRoutes.clockinArea,
      page: () => ClockInAreaScreen(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: AppRoutes.selfieClockin, // '/selfie-clock-in'
      page: () => SelfieClockInScreen(imagePath: ''),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: AppRoutes.attendanceDetail, // '/attendance-detail'
      page: () => const AttendanceDetailScreen(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: AppRoutes.notification, // '/attendance-detail'
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
    ),
    // profile screens

        GetPage(
      name: '/profile',
      page: () => MyProfileScreen(),
      binding: ProfileBinding(),
    ),
     GetPage(
      name: '/personal-data',
      page: () => const PersonalDataScreen(),
    ),
    GetPage(
      name: '/office-assets',
      page: () => const OfficeAssetsScreen(),
    ),
    GetPage(
      name: '/payroll',
      page: () => const PayrollScreen(),
    ),
    GetPage(
      name: '/change-password',
      page: () => const ChangePasswordScreen(),
    ),
  ];
}
