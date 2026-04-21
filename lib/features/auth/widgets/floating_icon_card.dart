import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';

class FloatingIconCard extends StatelessWidget {
  final String assetPath;
  final double? bottom;
  final double? iconSize;
  final double? containerSize;

  const FloatingIconCard({
    super.key,
    required this.assetPath,
    this.bottom,
    this.iconSize,
    this.containerSize,
  });

  @override
  Widget build(BuildContext context) {
    final double size = containerSize ?? 84.w;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: 0,
      right: 0,
      bottom: bottom ?? 300.h,
      child: Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF8B7CF6), Color(0xFF6C5CE7)],
            ),
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha((0.30 * 255).round()),
                blurRadius: 20.r,
                offset: Offset(0, 14.h),
              ),
              BoxShadow(
                color: AppColors.primary.withAlpha((0.12 * 255).round()),
                blurRadius: 6.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(18.r),
            child: SvgPicture.asset(
              assetPath,
              width: iconSize ?? 30.w,
              height: iconSize ?? 30.w,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
