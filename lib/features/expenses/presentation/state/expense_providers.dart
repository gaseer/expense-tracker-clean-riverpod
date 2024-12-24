import 'package:expense_tracker/core/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/db_helper.dart';
import '../../../../core/widgets/customDateSwitchButton.dart';
import '../../data/models/expense_model.dart';
import '../../data/repository/expense_repository.dart';

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ExpenseRepository(database);
});

final expenseListProvider =
    StateNotifierProvider<ExpenseListNotifier, List<Expense>>((ref) {
  return ExpenseListNotifier(ref.read(expenseRepositoryProvider));
});

final filteredExpenseListProvider = Provider<List<Expense>>((ref) {
  final allExpenses = ref.watch(expenseListProvider);
  final selectedDate = ref.watch(selectedDateProvider);
  final dateRange = ref.watch(dateRangeProvider);

  if (selectedDate != null && ref.watch(selectedContainerProvider) == 3) {
    return allExpenses.where((expense) {
      return expense.date.year == selectedDate.year &&
          expense.date.month == selectedDate.month &&
          expense.date.day == selectedDate.day;
    }).toList();
  }

  if (dateRange != null) {
    print(dateRange);
    print('dateRange');
    return allExpenses.where((expense) {
      return expense.date.isAfter(dateRange.start) &&
          expense.date.isBefore(dateRange.end);
    }).toList();
  }

  return allExpenses;
});

final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

class ExpenseListNotifier extends StateNotifier<List<Expense>> {
  final ExpenseRepository _repository;
  String currentSortOrder = 'descending';

  ExpenseListNotifier(this._repository) : super([]) {
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    state = await _repository.getAllExpenses();
  }

  void addExpense(Expense expense) async {
    await _repository.addExpense(expense);
    loadExpenses();
  }

  void updateExpense(Expense expense) async {
    await _repository.updateExpense(expense);
    loadExpenses();
  }

  void deleteExpense(Expense exp, context) async {
    await _repository.deleteExpense(exp.id!);
    showSnackBar(
      content: '${exp.title} deleted successfully',
      context: context,
      color: Colors.redAccent.withOpacity(.6),
    );
    loadExpenses();
  }

  void sortByDate({bool ascending = false}) {
    state = [...state]..sort((a, b) =>
        ascending ? a.date.compareTo(b.date) : b.date.compareTo(a.date));
  }
}
