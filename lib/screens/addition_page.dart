import 'package:debit_credit/shared/input_decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:debit_credit/services/database.dart';

class Addition extends StatefulWidget {
  const Addition({Key? key}) : super(key: key);

  @override
  _AdditionState createState() => _AdditionState();
}

class _AdditionState extends State<Addition> {
  final user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();
  List modes = ["Debit", "Credit", "Loan given", "Loan taken"];
  String _modeSelected = "Credit";
  String _task = "";
  String _details = "";
  double _amount = 0.0;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Add New Transaction Here"),
                Spacer(),
                DropdownButtonFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Transaction Type',
                    suffixIcon: Icon(Icons.person),
                  ),
                  value: "Credit",
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
                    });
                  },
                ),
                Spacer(),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Transaction Details',
                    suffixIcon: Icon(Icons.text_snippet_outlined),
                  ),
                  // initialValue: userData!.name,
                  // userData!.name
                  // decoration: textInputDecoration.copyWith(
                  //   hintText: 'Name',
                  // ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter transaction details' : null,
                  onChanged: (value) {
                    setState(() {
                      _details = value.toString();
                    });
                  },
                ),
                Spacer(),
                TextFormField(
                  decoration: textInputDecoration,
                  keyboardType: TextInputType.number,
                  // initialValue: userData!.name,
                  // userData!.name
                  // decoration: textInputDecoration.copyWith(
                  //   hintText: 'Name',
                  // ),

                  validator: (value) =>
                      value!.isEmpty ? 'Enter the amount' : null,
                  onChanged: (value) {
                    setState(() {
                      _amount = double.parse(value);
                    });
                  },
                ),
                Spacer(),
                DateTimeFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Transaction Date',
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                  ),

                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  // validator: (e) =>
                  //     (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  //  validator: (value) =>
                  //     value!. ? 'Select a date' : null,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      _date = value;
                    });
                  },
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // if (_currentName == '') {
                        //   _currentName = userData.name;
                        // }
                        // if (_currentSugar == '-1') {
                        //   _currentSugar = userData.sugar;
                        // }
                        await DatabaseService(uid: user.uid).updateTransaction(
                            _details, _modeSelected, _amount, _date);
                        Navigator.pop(context);
                      }
                      print("Details $_details");
                      print("Amount $_amount");
                      print("Mode $_modeSelected");
                      print("Date $_date");
                    },
                    child: Text("Add")),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
