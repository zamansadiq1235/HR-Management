
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';



class BurnoutStatsScreen extends StatelessWidget {
  const BurnoutStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.chevron_left_rounded,
                color: AppColors.primary, size: 22),
          ),
        ),
        title: const Text(
          'Burnout Stats',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Burnout status card ───────────────
            _StatCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Burnout Stats',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00C897),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Good',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "You've maintain your task at the right pace! keep it up!",
                    style: TextStyle(fontSize: 12, color: AppColors.textHint),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Text('😊', style: TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: 0.35,
                            backgroundColor: const Color(0xFFEEEEF5),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF00C897)),
                            minHeight: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Working Level chart ───────────────
            _StatCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Working Level',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Your story point so far',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textHint),
                  ),
                  const SizedBox(height: 20),
                  _BarChart(),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Working Period chart ──────────────
            _StatCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Working Period',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Average your working period',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textHint),
                  ),
                  const SizedBox(height: 20),
                  _LineChart(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final Widget child;
  const _StatCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ── Bar chart (custom paint) ─────────────────────────────────
class _BarChart extends StatelessWidget {
  final _data = const [
    ('Sprint 1', 92.0, false),
    ('Sprint 2', 100.0, false),
    ('Sprint 3', 95.0, false),
    ('Sprint 4', 113.0, true),  // highlighted
    ('Sprint 5', 98.0, false),
  ];

  @override
  Widget build(BuildContext context) {
    const maxVal = 120.0;
    const minVal = 80.0;
    const chartH = 120.0;

    return Column(
      children: [
        // Y-axis labels + bars
        SizedBox(
          height: chartH + 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Y labels
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['120', '110', '100', '90', '80']
                    .map((l) => Text(l,
                        style: const TextStyle(
                            fontSize: 9, color: AppColors.textHint)))
                    .toList(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: _data.map((d) {
                          final barH = ((d.$2 - minVal) /
                                  (maxVal - minVal)) *
                              chartH;
                          return Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (d.$3)
                                    Text(
                                      '${d.$2.toInt()}',
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  const SizedBox(height: 2),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(6)),
                                    child: Container(
                                      height: barH,
                                      color: d.$3
                                          ? AppColors.primary
                                          : AppColors.primarySurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: _data
                          .map((d) => Expanded(
                                child: Text(
                                  d.$1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: d.$3
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: d.$3
                                        ? AppColors.primary
                                        : AppColors.textHint,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Line / Area chart (custom paint) ────────────────────────
class _LineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 140),
      painter: _LineChartPainter(),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pts = [
      Offset(0, size.height * 0.55),
      Offset(size.width * 0.25, size.height * 0.5),
      Offset(size.width * 0.5, size.height * 0.45),
      Offset(size.width * 0.65, size.height * 0.1),  // peak
      Offset(size.width * 0.85, size.height * 0.5),
      Offset(size.width, size.height * 0.48),
    ];

    final fillPaint = Paint()
      ..color = const Color(0xFF6C5CE7).withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = const Color(0xFF6C5CE7).withOpacity(0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF6C5CE7)
      ..style = PaintingStyle.fill;

    // Build smooth path
    final path = Path()..moveTo(pts[0].dx, pts[0].dy);
    for (int i = 0; i < pts.length - 1; i++) {
      final cp1 = Offset(
          (pts[i].dx + pts[i + 1].dx) / 2, pts[i].dy);
      final cp2 = Offset(
          (pts[i].dx + pts[i + 1].dx) / 2, pts[i + 1].dy);
      path.cubicTo(
          cp1.dx, cp1.dy, cp2.dx, cp2.dy, pts[i + 1].dx, pts[i + 1].dy);
    }

    // Fill area
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(fillPath, fillPaint);

    // Line
    canvas.drawPath(path, linePaint);

    // Dots
    for (final p in pts) {
      canvas.drawCircle(p, 4, dotPaint);
      canvas.drawCircle(
          p,
          4,
          Paint()
            ..color = Colors.white
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke);
    }

    // X labels
    const labels = ['May', 'Jun', 'Jul', 'Aug', 'Sept'];
    const style = TextStyle(fontSize: 9, color: Color(0xFF9B9BAD));
    for (int i = 0; i < labels.length; i++) {
      final x = i * size.width / (labels.length - 1);
      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: style),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas,
          Offset(x - tp.width / 2, size.height - tp.height));
    }
  }

  @override
  bool shouldRepaint(_) => false;
}