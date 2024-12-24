import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/presentation/state/category_provider.dart';
import '../widgets/amount_progressBar.dart';
import 'expense_providers.dart';

final arcValuesProvider = Provider<List<ArcValueModel>>((ref) {
  final filteredExpenses = ref.watch(filteredExpenseListProvider);
  final categories = ref.watch(categoriesProvider).asData?.value ?? [];

  final categoryColors = {
    for (var category in categories)
      category.id: Color(category.colorCode ?? 0xff00FAD9)
  };

  final Map<String, double> categoryAmounts = {};
  double totalAmount = 0.0;

  for (var expense in filteredExpenses) {
    categoryAmounts.update(
      expense.categoryId,
      (value) => value + expense.amount,
      ifAbsent: () => expense.amount,
    );
    totalAmount += expense.amount;
  }

  if (totalAmount == 0) return [];

  return categoryAmounts.entries.map((entry) {
    final double arcValue = (entry.value / totalAmount) * 360;
    final color =
        categoryColors[int.parse(entry.key.toString())] ?? Colors.grey;
    return ArcValueModel(color: color, value: arcValue);
  }).toList();
});

final totalAmountProvider = Provider<double>((ref) {
  final filteredExpenses = ref.watch(filteredExpenseListProvider);
  return filteredExpenses.fold(0.0, (sum, expense) => sum + expense.amount);
});
