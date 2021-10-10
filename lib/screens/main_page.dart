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
  final modes = ["All", "Important"];
  String _modeSelected = 'All';
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
      catchError: (_, __) => null,
      initialData: null,
      value: DatabaseService(uid: user.uid).transactions(_modeSelected),
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Filter"),
                    IconButton(
                        onPressed: _filter,
                        icon: Icon(Icons.filter_alt_outlined)),
                  ],
                ),
              ),
              Expanded(
                child: TransactionList(),
                // child: DatabaseService(uid: user.uid).onPressed(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _filter() {
    print("Clicked Filter");
    // Container(
    //   child: filterBox(),
    // );

    showModalBottomSheet(context: context, builder: (context) => filterBox());
  }

  filterBox() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(20),
            // hintStyle: TextStyle(color: Colors.black45),
            errorStyle: TextStyle(color: Colors.redAccent),
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.filter_alt_outlined),
            labelText: 'Filter',
          ),
          value: _modeSelected,
          items: modes.map((mode) {
            return DropdownMenuItem(
              value: mode,
              child: Text("$mode"),
            );
          }).toList(),
          //  validator: (value) =>
          //     value!.isEmpty ? 'Enter the amount' : null,
          onChanged: (value) {
            setState(() {
              _modeSelected = value.toString();
              // DatabaseService(uid: user.uid).filter(_modeSelected);
            });
          },
        ),
      ),
    );
  }
}
