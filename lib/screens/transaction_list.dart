import 'package:debit_credit/models/transaction.dart' as t;
import 'package:debit_credit/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    // TODO: implement initState
    DatabaseService(uid: user.uid).onPressed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<List<t.Transaction>?>(context);
    int len;
    if (transactions != null) {
      len = transactions.length;
      transactions.forEach((transaction) {
        print(transaction.date);
        print(transaction.details);
        print(transaction.type);
        print(transaction.amount);
      });
    } else {
      len = 0;
    }
    print(len);

    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.5,
              shadowColor: Colors.black,
              color: Colors.brown[100],
              child: ListTile(
                title: Text('transactions[index].details'),
                // title: Text(transactions.docs[index]['strength'].toString()),
                subtitle: Text('transactions[index].amount.toString()'),
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
