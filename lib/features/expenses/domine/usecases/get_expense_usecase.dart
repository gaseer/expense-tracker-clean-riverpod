import 'package:expense_tracker/features/expenses/data/repository/expense_repository.dart';

import '../../data/models/expense_model.dart';

class GetExpenseUseCase {
  final ExpenseRepository repository;

  GetExpenseUseCase(this.repository);

  Future<List<Expense>> execute() async {
    return await repository.getAllExpenses();
  }
}
