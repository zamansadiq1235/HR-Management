import 'package:flutter/material.dart';
import 'package:hrmanagement/core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';
import '../models/meeting_model.dart';

class MeetingCard extends StatelessWidget {
  final MeetingModel meeting;
  final VoidCallback? onJoin;

  const MeetingCard({super.key, required this.meeting, this.onJoin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.divider,
          border: Border.all(color: AppColors.textHint, width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.videocam,
                    color: AppColors.cardBg,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 5),

                // Title + avatars
                Text(
                  meeting.title,
                  style: AppTextStyles.bodyText2.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 12,
                      color: AppColors.textHint,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      meeting.time,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AvatarRow(
                  count: meeting.members.length,
                  extraCount: meeting.extraMemberCount,
                ),

                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: onJoin ?? () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text("Join Meet"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stacked Avatar Row ──────────────────────────────────────
class _AvatarRow extends StatelessWidget {
  final int count;
  final int extraCount;

  const _AvatarRow({required this.count, this.extraCount = 0});

  static const double _size = 26;
  static const double _overlap = 16;

  @override
  Widget build(BuildContext context) {
    final total = count + (extraCount > 0 ? 1 : 0);
    final width = _size + (total - 1).clamp(0, 99) * _overlap;
    final List<String> dummyAvatars = [
      "assets/images/Ellipse1.png",
      "assets/images/Ellipse.png",
      "assets/images/Ellipse2.png",
    ];

    return SizedBox(
      width: width,
      height: _size,
      child: Stack(
        children: [
          ...List.generate(
            count,
            (i) => Positioned(
              left: i * _overlap,
              child: _circle(dummyAvatars[i % dummyAvatars.length]),
            ),
          ),
          if (extraCount > 0)
            Positioned(left: count * _overlap, child: _extraBadge(extraCount)),
        ],
      ),
    );
  }

  Widget _circle(String? imageUrl) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFDDE0FF),
        border: Border.all(color: Colors.white, width: 1.5),
        image: DecorationImage(
          image: AssetImage(imageUrl ?? "assets/images/Ellipse1.png"),
          fit: BoxFit.contain,
        ),
      ),
      
    );
  }

  Widget _extraBadge(int n) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFEEEBFF),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Center(
        child: Text(
          '+$n',
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6C5CE7),
          ),
        ),
      ),
    );
  }
}
