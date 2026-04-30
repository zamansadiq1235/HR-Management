import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../features/auth/controller/auth_view_model.dart';

class CustomPhonefield extends StatelessWidget {
  const CustomPhonefield({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number', style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 5),
        IntlPhoneField(
          disableLengthCheck: true,
          keyboardType: TextInputType.phone,
          controller: controller.phoneController,
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
