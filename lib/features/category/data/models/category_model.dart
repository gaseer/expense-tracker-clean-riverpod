class Category {
  final int? id;
  final String name;
  final double amount;
  final int? colorCode;

  Category({this.id, required this.name, required this.amount, this.colorCode});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'colorCode': colorCode,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      colorCode: map['colorCode'],
    );
  }
}
