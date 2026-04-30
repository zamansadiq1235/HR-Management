import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../constants/app_colors.dart';

class CustomPhonefield extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  const CustomPhonefield({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: AppColors.textSecondary),
        ),
        SizedBox(height: 5),
        IntlPhoneField(
          disableLengthCheck: true,
          keyboardType: TextInputType.phone,
          controller: controller,
          decoration: InputDecoration(
            hintText: '820000 0000',
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            border: OutlineInputBorder(borderSide: BorderSide()),
          ),
          initialCountryCode: 'PK',
          onChanged: (phone) {
            // ignore: avoid_print
            print(phone.completeNumber);
          },
        ),
      ],
    );
  }
}
