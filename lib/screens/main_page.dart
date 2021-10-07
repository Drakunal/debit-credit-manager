import 'package:debit_credit/screens/addition_page.dart';
import 'package:debit_credit/screens/dummy.dart';
import 'package:debit_credit/screens/transaction_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debit_credit/services/database.dart';
import 'package:provider/provider.dart';
import 'package:debit_credit/models/transaction.dart' as t;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser!;
  _addTransaction() {
    showModalBottomSheet(context: context, builder: (context) => Addition());
  }
  // void _addTransaction() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           padding: EdgeInsets.all(20),
  //           child: Addition(),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<t.Transaction>?>.value(
      initialData: null,
      value: DatabaseService(uid: user.uid).transactions,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          // onPressed: DatabaseService(
          //   uid: user.uid,
          // ).onPressed(),
          onPressed: _addTransaction,
          child: Icon(Icons.add),
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: TransactionList(),
            // child: DatabaseService(uid: user.uid).onPressed(),
          ),
        ),
      ),
    );
  }
}
