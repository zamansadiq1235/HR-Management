// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';

class BottomButtonWrapper extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final double bottomPadding;

  const BottomButtonWrapper({
    super.key,
    required this.label,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.bottomPadding = 28.0, // Default padding for modern iPhones/Androids
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          // Optional: Adds a subtle shadow to separate button from content
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16, 12, 16, bottomPadding),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: CustomButton(
          text: label,
          onPressed: onTap,
        ),
      ),
    );
  }
}