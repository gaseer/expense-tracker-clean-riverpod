import 'package:expense_tracker/features/expenses/data/repository/expense_repository.dart';

import '../../data/models/expense_model.dart';

class AddExpenseUseCase {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  Future<void> execute(Expense expense) async {
    await repository.addExpense(expense);
  }
}
