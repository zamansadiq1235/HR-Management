// ─── lib/features/profile/bindings/profile_binding.dart ─────

import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

// ─── Routes to add to AppPages ───────────────────────────────
//
// GetPage(
//   name: '/profile',
//   page: () => MyProfileScreen(),
//   binding: ProfileBinding(),
// ),
// GetPage(
//   name: '/personal-data',
//   page: () => const PersonalDataScreen(),
// ),
// GetPage(
//   name: '/office-assets',
//   page: () => const OfficeAssetsScreen(),
// ),
// GetPage(
//   name: '/payroll',
//   page: () => const PayrollScreen(),
// ),
// GetPage(
//   name: '/change-password',
//   page: () => const ChangePasswordScreen(),
// ),
//
// ─── File structure ───────────────────────────────────────────
//
// lib/features/profile/
// ├── models/
// │   └── profile_model.dart     (ProfileModel, PayrollMonthModel,
// │                               PayrollDetailModel, AssetModel)
// ├── controllers/
// │   └── profile_controller.dart
// ├── bindings/
// │   └── profile_binding.dart
// └── screens/
//     ├── profile_screen.dart          → MyProfileScreen
//     ├── personal_data_screen.dart    → PersonalDataScreen
//     └── profile_sub_screens.dart     → ChangePasswordScreen
//                                         OfficeAssetsScreen
//                                         PayrollScreen
//                                         PayrollDetailScreen