import 'dart:async';

import 'package:debit_credit/models/transaction.dart' as t;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debit_credit/shared/hexcolor.dart';
import 'package:flutter/material.dart';

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
      'date': date,
      'star': '#808080'
    });
  }

  Stream<List<t.Transaction>> transactions(String filterBy) {
    // print("Hi this is the $uid");
    // return transactionCollection
    //     .where('userId', isEqualTo: uid)
    //     .orderBy('date')
    //     .snapshots()
    //     .map(_transactionListFromSnapshot);

    String filterText = '';
    if (filterBy == 'Important') {
      filterText = '#ffbf00';
      print("Filter Text is $filterBy");
      return transactionCollection
          .where('userId', isEqualTo: uid)
          .where('star', isEqualTo: filterText)
          .orderBy('date')
          .snapshots()
          .map(_transactionListFromSnapshot);
    } else if (filterBy == 'Credit' ||
        filterBy == 'Debit' ||
        filterBy == 'Loan taken' ||
        filterBy == 'Loan given') {
      print("Filter Text is $filterBy");
      return transactionCollection
          .where('userId', isEqualTo: uid)
          .where('mode', isEqualTo: filterBy)
          .orderBy('date')
          .snapshots()
          .map(_transactionListFromSnapshot);
    } else {
      print("Filter Text is $filterBy");
      return transactionCollection
          .where('userId', isEqualTo: uid)
          .orderBy('date')
          .snapshots()
          .map(_transactionListFromSnapshot);
    }
  }

  List<t.Transaction> _transactionListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // print(doc.id);
      Color temp = HexColor(doc.get('star') ?? '#808080');
      return t.Transaction(
          id: doc.id,
          amount: doc.get('amount') ?? 0,
          details: doc.get('details') ?? ' ',
          type: doc.get('mode') ?? '',
          date: doc.get('date').toDate() ?? DateTime.now(),
          star: temp);
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

  Future updateStar(String star) async {
    // return await transactionCollection.doc(uid).set(
    //     {'details': details, 'mode': mode, 'amount': amount, 'date': date});
    return await transactionCollection.doc(uid).update({
      // 'userId': uid,
      // 'details': details,
      // 'mode': mode,
      // 'amount': amount,
      // 'date': date,
      'star': star
    });
  }

  Future deleteSingleTransaction(String id) async {
    return await transactionCollection.doc(id).delete();
  }

  // Future filter(String filterBy) async {
  //   String filterText = '';
  //   if (filterBy == 'Important') {
  //     filterText = '#ffbf00';
  //     return transactionCollection
  //         .where('userId', isEqualTo: uid)
  //         .where('star', isEqualTo: filterText)
  //         .orderBy('date')
  //         .snapshots()
  //         .map(_transactionListFromSnapshot);
  //   } else {
  //     return transactionCollection
  //         .where('userId', isEqualTo: uid)
  //         .orderBy('date')
  //         .snapshots()
  //         .map(_transactionListFromSnapshot);
  //   }
  //   // return await transactionCollection.doc(uid).set(
  //   //     {'details': details, 'mode': mode, 'amount': amount, 'date': date});
  //   // return await transactionCollection.doc(uid).update({
  //   //   // 'userId': uid,
  //   //   // 'details': details,
  //   //   // 'mode': mode,
  //   //   // 'amount': amount,
  //   //   // 'date': date,
  //   //   'star': star
  //   // });
  // }
}
