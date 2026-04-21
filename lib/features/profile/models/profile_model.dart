// ─── lib/features/profile/models/profile_model.dart ─────────

class ProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String position;
  final String address;
  final String country;
  final String state;
  final String city;
  final String fullAddress;
  final String dateOfBirth;
  final String? avatarPath;

  const ProfileModel({
    this.firstName = 'Tonald',
    this.lastName = 'Drump',
    this.email = 'Tonald@gmail.com',
    this.position = 'Junior Full Stack Developer',
    this.address = 'Taman Anggrek',
    this.country = 'Indonesia',
    this.state = 'DKI Jakarta',
    this.city = 'Jakarta Selatan',
    this.fullAddress =
        'Jl Mampang Prapatan XIV No 7A, Jakarta Selatan 12790',
    this.dateOfBirth = '10 December 1997',
    this.avatarPath,
  });

  ProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? position,
    String? address,
    String? country,
    String? state,
    String? city,
    String? fullAddress,
    String? dateOfBirth,
    String? avatarPath,
  }) =>
      ProfileModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        position: position ?? this.position,
        address: address ?? this.address,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        fullAddress: fullAddress ?? this.fullAddress,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        avatarPath: avatarPath ?? this.avatarPath,
      );

  String get fullName => '$firstName $lastName';
}

// ─── lib/features/profile/models/payroll_model.dart ─────────

class PayrollMonthModel {
  final String month;       // e.g. "September 2024"
  final String totalHours;  // e.g. "40:00:00 hrs"
  final String received;    // e.g. "\$800"
  final String paidOn;      // e.g. "30 Sept 2024"

  const PayrollMonthModel({
    required this.month,
    required this.totalHours,
    required this.received,
    required this.paidOn,
  });
}

class PayrollDetailModel {
  final String period;
  final String overtimeHrs;
  final String payPeriodHrs;
  final double basicSalary;
  final double tax;
  final double reimbursement;
  final double bonus;
  final double overtime;

  const PayrollDetailModel({
    this.period = 'Paid Period 1 Sept 2024 - 30 Sept 2024',
    this.overtimeHrs = '00:00',
    this.payPeriodHrs = '40:00',
    this.basicSalary = 700,
    this.tax = 70,
    this.reimbursement = 70,
    this.bonus = 100,
    this.overtime = 0,
  });

  double get totalSalary =>
      basicSalary - tax + reimbursement + bonus + overtime;
}

// ─── lib/features/profile/models/asset_model.dart ───────────

class AssetModel {
  final String name;
  final String brand;
  final String warrantyStatus;
  final String buyingDate;
  final String receivedOn;
  final String? imagePath;

  const AssetModel({
    this.name = 'Laptop Macbook Air M1 2020',
    this.brand = 'Apple',
    this.warrantyStatus = 'Off',
    this.buyingDate = '12 September 2020',
    this.receivedOn = '14 September 2020',
    this.imagePath,
  });
}