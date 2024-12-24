import 'package:expense_tracker/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedContainerProvider = StateProvider<int?>((ref) => null);

final dateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);

class CustomDateSwitchButton extends ConsumerWidget {
  final bool isSelected;
  final int index;
  final String label;
  final double w;

  const CustomDateSwitchButton({
    super.key,
    required this.isSelected,
    required this.index,
    required this.label,
    required this.w,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = isSelected ? gray60 : gray;

    return GestureDetector(
      onTap: () {
        ref.read(selectedContainerProvider.notifier).state = index;
        ref.read(dateRangeProvider.notifier).state =
            _getDateForSelectedOption(index);
      },
      child: Container(
        width: w * .2,
        height: w * .12,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selectedColor,
          border: Border.all(
            color: Colors.white30,
            style: BorderStyle.solid,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  DateTimeRange _getDateForSelectedOption(int index) {
    final now = DateTime.now();
    switch (index) {
      case 0:
        return DateTimeRange(
            start: now.subtract(const Duration(days: 7)), end: now);
      case 1:
        return DateTimeRange(
            start: DateTime(now.year, now.month - 1, now.day), end: now);
      case 2:
        return DateTimeRange(
            start: DateTime(now.year - 1, now.month, now.day), end: now);
      default:
        return DateTimeRange(start: now, end: now);
    }
  }
}
