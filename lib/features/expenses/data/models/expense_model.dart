class Expense {
  final int? id;
  final double amount;
  final String categoryId;
  final String? description;
  final String? title;
  final DateTime date;

  Expense({
    this.id,
    required this.amount,
    required this.categoryId,
    required this.title,
    this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'description': description,
      'categoryId': categoryId,
      'title': title,
      'date': date.toIso8601String(),
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as int?,
      title: map['title'] as String?,
      categoryId: map['categoryId'] as String ?? "",
      amount: map['amount'] as double,
      description: map['description'] as String?,
      date: DateTime.parse(map['date']),
    );
  }
}
