import 'dart:async';

import 'package:debit_credit/models/transaction.dart' as t;
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

  Stream<List<t.Transaction>> get transactions {
    print("Hi this is the $uid");
    return transactionCollection
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map(_transactionListFromSnapshot);
  }

  List<t.Transaction> _transactionListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // print(doc.get('amount'));
      return t.Transaction(
          amount: doc.get('amount') ?? 0,
          details: doc.get('details') ?? ' ',
          type: doc.get('mode') ?? '',
          date: doc.get('date').toDate() ?? DateTime.now());
    }).toList();
  }

  Stream<List<t.Transaction>> onPressed() {
    // try {

    return transactionCollection
        .where('mode', isEqualTo: 'Credit')
        .snapshots()
        // .get()
        .map(_transactionListFromSnapshot);
    // return _transactionListFromSnapshot(
    //     transactionCollection.where('mode', isEqualTo: 'Credit').get());

    // return transactionCollection
    //     .where('mode', isEqualTo: 'Credit')
    //     .get()
    //     .then((querySnapshot) {
    //   // querySnapshot.docs.forEach((result) {
    //   _transactionListFromSnapshot(querySnapshot);
    //   // }
    //   // );
    // });
    // } catch (e) {
    //   print(e.toString());
    // }
  }
}
