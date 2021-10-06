class Transaction {
  final String details;
  final String type;
  final double amount;
  final DateTime date;
  Transaction(
      {required this.amount,
      required this.date,
      required this.details,
      required this.type});
}
