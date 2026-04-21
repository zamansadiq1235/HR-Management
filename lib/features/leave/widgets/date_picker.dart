// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class LeaveDatePickerSheet extends StatefulWidget {
  final DateTime? initialStart;
  final DateTime? initialEnd;

  const LeaveDatePickerSheet({super.key, this.initialStart, this.initialEnd});

  static Future<DateTimeRange?> show({
    required BuildContext context,
    DateTime? initialStart,
    DateTime? initialEnd,
  }) {
    return showModalBottomSheet<DateTimeRange>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LeaveDatePickerSheet(
        initialStart: initialStart,
        initialEnd: initialEnd,
      ),
    );
  }

  @override
  State<LeaveDatePickerSheet> createState() => _LeaveDatePickerSheetState();
}

class _LeaveDatePickerSheetState extends State<LeaveDatePickerSheet> {
  late DateTime _focusedMonth;
  DateTime? _start;
  DateTime? _end;

  // ── Today at midnight — single source of truth ───────────
  late final DateTime _today = _strip(DateTime.now());

  static const _purple = AppColors.primary;
  static const _purpleLight = AppColors.primarySurface;
  static const _textPrimary = AppColors.textPrimary;
  static const _textHint = AppColors.textHint;
  static const _weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  void initState() {
    super.initState();
    _start = widget.initialStart;
    _end = widget.initialEnd;
    // Always open on today's month regardless of initialStart
    _focusedMonth = DateTime(_today.year, _today.month);
  }

  // ── Helpers ──────────────────────────────────────────────
  DateTime _strip(DateTime d) => DateTime(d.year, d.month, d.day);

  /// True when date is strictly before today
  bool _isPast(DateTime date) => _strip(date).isBefore(_today);

  bool _isSameDay(DateTime? a, DateTime? b) =>
      a != null &&
      b != null &&
      a.year == b.year &&
      a.month == b.month &&
      a.day == b.day;

  bool _isInRange(DateTime day) {
    if (_start == null || _end == null) return false;
    final d = _strip(day);
    return d.isAfter(_strip(_start!)) && d.isBefore(_strip(_end!));
  }

  DateTime get _firstDayOfMonth =>
      DateTime(_focusedMonth.year, _focusedMonth.month, 1);

  DateTime get _lastDayOfMonth =>
      DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);

  /// Back arrow is disabled when we are already on the current month
  bool get _canGoPrev =>
      _focusedMonth.year > _today.year ||
      (_focusedMonth.year == _today.year && _focusedMonth.month > _today.month);

  String _monthLabel(DateTime d) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[d.month - 1]} ${d.year}';
  }

  // ── Tap handler — silently ignores past + outside dates ──
  void _onDayTapped(DateTime day) {
    if (day.month != _focusedMonth.month) return;
    if (_isPast(day)) return; // past = not selectable

    setState(() {
      if (_start == null || (_start != null && _end != null)) {
        _start = day;
        _end = null;
      } else {
        if (day.isBefore(_start!)) {
          _end = _start;
          _start = day;
        } else if (_isSameDay(day, _start)) {
          _start = null;
        } else {
          _end = day;
        }
      }
    });
  }

  // ── Build ────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),
          _buildHeader(),
          const SizedBox(height: 16),
          _buildWeekdayRow(),
          const SizedBox(height: 8),
          _buildDaysGrid(),
          const SizedBox(height: 24),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 20),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Leave Duration',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: _textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Select Leave Duration',
          style: TextStyle(fontSize: 13, color: _purple),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _NavButton(
              icon: Icons.chevron_left_rounded,
              enabled: _canGoPrev,
              onTap: () {
                if (_canGoPrev) {
                  setState(
                    () => _focusedMonth = DateTime(
                      _focusedMonth.year,
                      _focusedMonth.month - 1,
                    ),
                  );
                }
              },
            ),
            Expanded(
              child: Text(
                _monthLabel(_focusedMonth),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _textPrimary,
                ),
              ),
            ),
            _NavButton(
              icon: Icons.chevron_right_rounded,
              enabled: true,
              onTap: () => setState(
                () => _focusedMonth = DateTime(
                  _focusedMonth.year,
                  _focusedMonth.month + 1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeekdayRow() {
    return Row(
      children: _weekdays
          .map(
            (d) => Expanded(
              child: Text(
                d,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _textHint,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDaysGrid() {
    final firstWeekday = _firstDayOfMonth.weekday % 7; // Sun=0…Sat=6
    final lastDay = _lastDayOfMonth.day;
    final prevMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    final prevLastDay = DateTime(
      _focusedMonth.year,
      _focusedMonth.month,
      0,
    ).day;
    final totalCells = (firstWeekday + lastDay + 6) ~/ 7 * 7;

    final cells = <_DayCell>[];
    for (int i = 0; i < totalCells; i++) {
      final offset = i - firstWeekday;
      if (offset < 0) {
        final day = prevLastDay + offset + 1;
        cells.add(
          _DayCell(
            day: day,
            date: DateTime(prevMonth.year, prevMonth.month, day),
            isCurrentMonth: false,
          ),
        );
      } else if (offset >= lastDay) {
        final day = offset - lastDay + 1;
        cells.add(
          _DayCell(
            day: day,
            date: DateTime(_focusedMonth.year, _focusedMonth.month + 1, day),
            isCurrentMonth: false,
          ),
        );
      } else {
        final day = offset + 1;
        cells.add(
          _DayCell(
            day: day,
            date: DateTime(_focusedMonth.year, _focusedMonth.month, day),
            isCurrentMonth: true,
          ),
        );
      }
    }

    final rows = <Widget>[];
    for (int row = 0; row < cells.length ~/ 7; row++) {
      rows.add(_buildWeekRow(cells.sublist(row * 7, row * 7 + 7)));
    }
    return Column(children: rows);
  }

  Widget _buildWeekRow(List<_DayCell> cells) {
    return Row(
      children: cells.asMap().entries.map((entry) {
        final i = entry.key;
        final cell = entry.value;

        final isPast = _isPast(cell.date);
        final isOutside = !cell.isCurrentMonth;
        final isDisabled = isPast || isOutside;

        final isStart = _isSameDay(cell.date, _start);
        final isEnd = _isSameDay(cell.date, _end);
        final inRange = _isInRange(cell.date) && !isDisabled;
        final isSelected = isStart || isEnd;
        final isToday = _isSameDay(cell.date, _today);

        // Range band: only draw on active (non-disabled) cells
        final showRangeLeft = (inRange || isEnd) && i != 0 && !isDisabled;
        final showRangeRight = (inRange || isStart) && i != 6 && !isDisabled;

        // Text colour hierarchy
        final Color textColor;
        if (isSelected) {
          textColor = Colors.white;
        } else if (isDisabled) {
          // Past and outside-month: clearly muted
          textColor = const Color(0xFFD0D0D0);
        } else if (isToday) {
          // Today gets a purple tint when not selected
          textColor = _purple;
        } else {
          textColor = _textPrimary;
        }

        return Expanded(
          child: GestureDetector(
            // Disabled cells get null onTap (no ripple, no response)
            onTap: isDisabled ? null : () => _onDayTapped(cell.date),
            child: SizedBox(
              height: 44,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Range band — left half
                  if (showRangeLeft)
                    Positioned(
                      left: 0,
                      top: 8,
                      bottom: 8,
                      width: 24,
                      child: Container(color: _purpleLight),
                    ),
                  // Range band — right half
                  if (showRangeRight)
                    Positioned(
                      right: 0,
                      top: 8,
                      bottom: 8,
                      width: 24,
                      child: Container(color: _purpleLight),
                    ),
                  // Circle (selected) or today ring
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: 36,
                    height: 27,
                    decoration: BoxDecoration(
                      color: isSelected ? _purple : Colors.transparent,
                      shape: BoxShape.circle,
                      border: isToday && !isSelected
                          ? Border.all(color: _purple, width: 1.2)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '${cell.day}',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: isSelected || inRange
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildButtons() {
    final canSubmit = _start != null && _end != null;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: canSubmit
                ? () => Navigator.pop(
                    context,
                    DateTimeRange(start: _start!, end: _end!),
                  )
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: canSubmit ? _purple : _purpleLight,
              disabledBackgroundColor: _purpleLight,
              foregroundColor: Colors.white,
              disabledForegroundColor: _purple.withOpacity(0.5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text('Submit Date'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context, null),
            style: OutlinedButton.styleFrom(
              foregroundColor: _purple,
              side: const BorderSide(color: _purple, width: 1.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text('Close Message'),
          ),
        ),
      ],
    );
  }
}

// ── Nav Button ───────────────────────────────────────────────
class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  const _NavButton({
    required this.icon,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: enabled ? AppColors.primarySurface : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: enabled ? AppColors.primary : const Color(0xFFCCCCCC),
          size: 20,
        ),
      ),
    );
  }
}

// ── Day cell data ────────────────────────────────────────────
class _DayCell {
  final int day;
  final DateTime date;
  final bool isCurrentMonth;

  const _DayCell({
    required this.day,
    required this.date,
    required this.isCurrentMonth,
  });
}
