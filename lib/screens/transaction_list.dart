import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debit_credit/models/transaction.dart' as t;
import 'package:debit_credit/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  late Stream<List<t.Transaction>?> data;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    // TODO: implement initState
    data = DatabaseService(uid: user.uid).onPressed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    final transactions = Provider.of<List<t.Transaction>?>(context);
    // print(data.then((value) => value!.docs.forEach((result) {
    //       print(result.data());
    //     })));

    // data.docs.forEach((result) {
    //   print(result.data());
    // });
    int len = 0;
    print(transactions);
    if (transactions != null) {
      len = transactions.length;
      // print(data.length.toString());
      // transactions.forEach((transaction) {
      //   print(transaction.date);
      //   print(transaction.details);
      //   print(transaction.type);
      //   print(transaction.amount);
      // });
    } else {
      len = 0;
    }
    print(len);

    return ListView.builder(
        itemCount: len,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.5,
              shadowColor: Colors.black,
              color: Colors.grey[100],
              child: ListTile(
                title: Text(transactions![index].details),
                // title: Text(transactions.docs[index]['strength'].toString()),
                subtitle: Text(transactions[index].type),
                trailing: Column(
                  children: [
                    Text(
                        'Transaction date: ${DateFormat('dd/MM/yyyy').format(transactions[index].date).toString()}'),
                    Spacer(),
                    Text('₹ ${transactions[index].amount.round().toString()}'),
                  ],
                ),
                // trailing: const Text("..."),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MovieListViewDetails(
                  //               movieName: movieList.elementAt(index).title,
                  //               movie: movieList[index],
                  //             )));
                },
                // onTap: () =>
                //     debugPrint("The movie name is ${movies.elementAt(index)}"),
              ),
            ),
          );
        });
  }
}
