import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debit_credit/models/transaction.dart' as t;
import 'package:debit_credit/services/database.dart';
import 'package:debit_credit/services/preferences.dart';
import 'package:debit_credit/shared/hexcolor.dart';
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
    // if (len == 0) {
    //   return Center(child: CircularProgressIndicator());
    // }

    return ListView.builder(
        itemCount: len,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 4.5,
                  shadowColor: Colors.black,
                  color: Colors.grey[100],
                  child: ListTile(
                    title: Text(
                      transactions![index].details,
                      style: TextStyle(color: Preference().getColor()),
                    ),
                    // title: Text(transactions.docs[index]['strength'].toString()),
                    subtitle: Text(
                        '${transactions[index].type}: ${DateFormat('dd/MM/yyyy').format(transactions[index].date).toString()}'),
                    leading: Text(
                        '₹ ${transactions[index].amount.round().toString()}'),

                    trailing: Column(
                      children: [
                        // Text(
                        //     '${DateFormat('dd/MM/yyyy').format(transactions[index].date).toString()}'),
                        // Text('₹ ${transactions[index].amount.round().toString()}'),
                        IconButton(
                            icon: Icon(
                              Icons.star,
                              color: transactions[index].star,
                            ),
                            onPressed: () {
                              _starToggle(transactions[index].id,
                                  transactions[index].star);
                            }),
                      ],
                    ),
                    // trailing: const Text("..."),
                    onLongPress: () {
                      print("Long Press Done ${transactions[index].id}");
                      _deleteDialog(transactions[index].id);
                    },
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
              ],
            ),
          );
        });
  }

  _starToggle(String id, Color star) {
    String s = '';
    if (star == HexColor('#808080')) {
      // star = HexColor('#ffbf00');
      s = '#ffbf00';
      // print(star.toString());
    } else {
      // star = HexColor('#808080');
      s = '#808080';
      print(star.toString());
    }
    DatabaseService(uid: id).updateStar(s);
  }

  void _deleteDialog(String id) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("Delete"),
              content: Text(
                  "Are you sure you want to delete this particular transaction?"),
              actions: [
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                        //Do not delete
                        onPressed: () {
                          // setEmptyFields();
                          Navigator.pop(context);
                        },
                        child: Text("No")),
                    Spacer(),
                    ElevatedButton(
                        //Delete
                        onPressed: () {
                          Navigator.pop(context);
                          _deleteTransaction(id);
                        },
                        child: Text("Yes")),
                    Spacer(),
                  ],
                )
              ],
            ));
  }

  void _deleteTransaction(String id) {
    DatabaseService(uid: user.uid).deleteSingleTransaction(id);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Deleted!"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            ));
  }
}
