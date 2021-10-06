import 'dart:async';

import 'package:debit_credit/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  //collection reference
  //creates a collection if not present, else makes the collection reference

  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection("transactions");
  //link is made with the collection named transactions

  Future updateTransaction(
      String details, String mode, double amount, DateTime date) async {
    // return await transactionCollection.doc(uid).set(
    //     {'details': details, 'mode': mode, 'amount': amount, 'date': date});
    return await transactionCollection.add({
      'userId': uid,
      'details': details,
      'mode': mode,
      'amount': amount,
      'date': date
    });
  }
}
