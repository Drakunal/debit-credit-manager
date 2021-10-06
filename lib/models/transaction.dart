class Transaction {
  String details;
  String type;
  double amount;
  DateTime date;
  Transaction(
      {required this.amount,
      required this.date,
      required this.details,
      required this.type});
}
