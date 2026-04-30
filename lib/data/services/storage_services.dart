import 'package:get_storage/get_storage.dart';

class StorageService {
  final _box = GetStorage();

  //  Keys
  static const _onboardingKey = 'onboarding_done';
  static const _isLoggedInKey = 'is_logged_in';
  static const _rememberKey = 'remember_me';
  static const _emailKey = 'saved_email';
  static const _employeeIdKey = 'saved_employee_id';

  // Onboarding
  bool get isOnboardingDone => _box.read(_onboardingKey) ?? false;

  void setOnboardingDone() => _box.write(_onboardingKey, true);

  // Auth
  bool get isLoggedIn => _box.read(_isLoggedInKey) ?? false;

  void setLoggedIn(bool value) => _box.write(_isLoggedInKey, value);

  

  // Remember Me
  bool get rememberMe => _box.read(_rememberKey) ?? false;

  void setRememberMe(bool value) => _box.write(_rememberKey, value);

  // Save Email
  void saveEmail(String email) => _box.write(_emailKey, email);
  String get email => _box.read(_emailKey) ?? '';

  // Save Employee ID
  void saveEmployeeId(String id) => _box.write(_employeeIdKey, id);
  String get employeeId => _box.read(_employeeIdKey) ?? '';

  void clearRememberData() {
    _box.remove(_emailKey);
    _box.remove(_employeeIdKey);
  }

  void logout() {
    _box.remove(_isLoggedInKey);
    _box.remove(_rememberKey);

    // optional: clear saved credentials
    _box.remove('saved_email');
    _box.remove('saved_employee_id');
  }
}