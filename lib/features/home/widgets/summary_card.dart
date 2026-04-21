import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B7AF8), Color(0xFF5849C2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0,
            top: 0,
            //bottom: -10,
            child: Image.asset(
              AppAssets.group, // placeholder; swap with asset
              width: 90,
              height: 65,
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
              errorBuilder: (_, _, _) => const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.videocam, color: Colors.white24, size: 60),
              ),
            ),
          ),
          // Text content
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Work Summary",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "Today task & presence activity",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
