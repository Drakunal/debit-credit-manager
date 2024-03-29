import 'package:debit_credit/screens/addition_page.dart';
import 'package:debit_credit/screens/dummy.dart';
import 'package:debit_credit/screens/transaction_list.dart';
import 'package:debit_credit/services/preferences.dart';
import 'package:debit_credit/shared/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debit_credit/services/database.dart';
import 'package:provider/provider.dart';
import 'package:debit_credit/models/transaction.dart' as t;
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String savedColorOriginal = '#FFFF00';
  Color color1 = Preference().getColor();
  final user = FirebaseAuth.instance.currentUser!;
  final modes = [
    "All",
    "Important",
    "Debit",
    "Credit",
    "Loan taken",
    "Loan given"
  ];

  String _modeSelected = 'All';
  String _filterMessage = 'Showing all results';

  String get _FilterMessage => "Filter by : $_modeSelected";

  _addTransaction() {
    showModalBottomSheet(context: context, builder: (context) => Addition());
  }

  _addMultipleTransaction() {
    List fakeModes = ['Credit', 'Debit', 'Loan given', 'Loan taken'];
    for (int i = 0; i < 1000; i++) {
      DatabaseService(uid: user.uid).updateTransaction("Details number $i",
          fakeModes[i % 4], (1000 + i).toDouble(), DateTime.now());
    }
  }

  getColor() {
    // String hexColor = getColorValue() ?? '';
    getColorValue();

    Color color = HexColor(savedColorOriginal);
    // print('From 1 $savedColorOriginal');
    return color;
  }

  getColorValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedColor = prefs.getString('colorName') ?? '#FFFF00';
    setState(() {
      savedColorOriginal = savedColor;
    });

    // print('From 2 $savedColorOriginal');
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
    if (_modeSelected != 'All') {
      _filterMessage = _FilterMessage;
    } else if (_modeSelected == 'All') {
      _filterMessage = 'Showing all results';
    }

    return StreamProvider<List<t.Transaction>?>.value(
      catchError: (_, __) => null,
      initialData: null,
      value: DatabaseService(uid: user.uid).transactions(_modeSelected),
      child: Scaffold(
        backgroundColor: color1,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: color1, //preference.getcolor not working here
        //   // onPressed: DatabaseService(
        //   //   uid: user.uid,
        //   // ).onPressed(),
        //   onPressed: _addTransaction,
        //   child: Icon(
        //     Icons.add,
        //     color: Colors.black,
        //   ),
        // ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_filterMessage),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Filter"),
                        IconButton(
                            onPressed: _filter,
                            icon: Icon(Icons.filter_alt_outlined)),
                      ],
                    ),
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
