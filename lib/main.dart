import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_pages.dart';
import 'data/services/storage_services.dart';

void main() async {
  // 1. Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize GetStorage and WAIT for it
  try {
    // Initialize storage and wait for it
    await GetStorage.init();
  } catch (e) {
    debugPrint("GetStorage Init Error: $e");
    // Fallback or handle error so the app doesn't stay blank
  }

  final storage = StorageService();
  String initialRoute = AppPages.onboarding; // Default route

  if (storage.isOnboardingDone && storage.isLoggedIn) {
    initialRoute = AppPages.navBar;
  } else if (storage.isOnboardingDone && !storage.isLoggedIn) {
    initialRoute = AppPages.signIn;
  }
  // else: keep default onboarding route

  runApp(HRManagementApp(initialRoute: initialRoute));
}

class HRManagementApp extends StatelessWidget {
  final String initialRoute;

  const HRManagementApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GetMaterialApp(
        title: 'HR Management',
        theme: AppTheme.lightTheme,
        initialRoute: initialRoute,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
