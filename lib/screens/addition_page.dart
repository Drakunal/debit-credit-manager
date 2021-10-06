import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

class Addition extends StatefulWidget {
  const Addition({Key? key}) : super(key: key);

  @override
  _AdditionState createState() => _AdditionState();
}

class _AdditionState extends State<Addition> {
  final _formKey = GlobalKey<FormState>();
  List modes = ["Debit", "Credit", "Loan given", "Loan taken"];
  String _modeSelected = "";
  String _task = "";
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
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.person),
                    labelText: 'Transaction Type',
                  ),
                  items: modes.map((mode) {
                    return DropdownMenuItem(
                      value: mode,
                      child: Text("$mode"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _modeSelected = value.toString();
                    });
                  },
                ),
                Spacer(),
                TextFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.text_snippet_outlined),
                    labelText: 'Transaction Details',
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
                      _task = value;
                    });
                  },
                ),
                Spacer(),
                TextFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.money),
                    labelText: 'Transaction amount',
                  ),
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
                      _task = value;
                    });
                  },
                ),
                Spacer(),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Transaction Date',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  // validator: (e) =>
                  //     (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    print(value);
                  },
                ),
                Spacer(),
                ElevatedButton(onPressed: null, child: Text("Add")),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
