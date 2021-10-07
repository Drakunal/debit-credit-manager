import 'dart:async';

import 'package:debit_credit/models/transaction.dart' as t;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dummy extends StatefulWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection("transactions");
  _getF() async {
    QuerySnapshot qs =
        await transactionCollection.where('age', isGreaterThan: 20).get();
    //     .then((querySnapshot) {
    //   querySnapshot.docs.forEach((result) {
    //     print(result.data());
    //   });
    // });
    // return qs;
  }

  //   Future<void> addUser() {
  //   // Call the user's CollectionReference to add a new user
  //   return users
  //       .add({
  //         'full_name': fullName, // John Doe
  //         'company': company, // Stokes and Sons
  //         'age': age // 42
  //       })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getF(),
    );
    // return FutureBuilder<QuerySnapshot>(
    //   future: _getF(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text("Something went wrong");
    //     }

    //     if (snapshot.hasData) {
    //       return Text("Document does not exist");
    //     }

    //     if (snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
    //       return Text("Details: ${data['details']} ${data['mode']}");
    //     }

    //     return Text("loading");
    //   },
    // );
  }
}

// class Dummy {
//   final String uid;

//   Dummy({required this.uid});

//   //collection reference
//   //creates a collection if not present, else makes the collection reference

//   final CollectionReference transactionCollection =
//       FirebaseFirestore.instance.collection("transactions");
//   //link is made with the collection named transactions

//   Future updateTransaction(
//       String details, String mode, double amount, DateTime date) async {
//     // return await transactionCollection.doc(uid).set(
//     //     {'details': details, 'mode': mode, 'amount': amount, 'date': date});
//     return await transactionCollection.add({
//       'userId': uid,
//       'details': details,
//       'mode': mode,
//       'amount': amount,
//       'date': date
//     });
//   }

//   Stream<List<t.Transaction>> get transactions {
//     return transactionCollection.snapshots().map(_transactionListFromSnapshot);
//   }

//   List<t.Transaction> _transactionListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.docs.map((doc) {
//       // print(doc.get('amount'));
//       return t.Transaction(
//           amount: doc.get('amount') ?? 0,
//           details: doc.get('details') ?? ' ',
//           type: doc.get('mode') ?? '',
//           date: doc.get('date') ?? DateTime.now());
//     }).toList();
//   }

//   onPressed() {
//     try {
//       transactionCollection
//           .where('age', isGreaterThan: 20)
//           .get()
//           .then((querySnapshot) {
//         querySnapshot.docs.forEach((result) {
//           print(result.data());
//         });
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
