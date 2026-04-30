//  Profile avatar ───────────────────────────────────────────
// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hrmanagement/core/constants/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String? avatarPath;
  const ProfileAvatar({this.avatarPath});

  Widget _buildImage(String path) {
    // If the path starts with 'assets/', treat it as an asset
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.person),
      );
    }

    // Otherwise, treat it as a file on the device
    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.person_rounded, color: AppColors.primary, size: 46),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEBFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: (avatarPath?.isNotEmpty ?? false)
            ? _buildImage(avatarPath!)
            : const _AvatarPlaceholder(),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  const _AvatarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEEBFF),
      child: Image.asset('assets/images/Ellipse2.png', fit: BoxFit.cover),
    );
  }
}
