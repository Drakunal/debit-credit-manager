import 'package:debit_credit/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<List<Transaction>?>(context);
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
    return ListView.builder(
        itemCount: len,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.5,
              shadowColor: Colors.black,
              color: Colors.brown[100],
              child: ListTile(
                // leading: CircleAvatar(
                //   backgroundColor: Colors.brown[transactions![index].strength],
                //   backgroundImage: AssetImage(
                //     'assets/tea.png',
                //   ),
                //   radius: 30,
                // ),
                title: Text(transactions![index].details),
                // title: Text(transactions.docs[index]['strength'].toString()),
                subtitle:
                    Text("Takes ${transactions[index].amount} spoons of sugar"),
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
