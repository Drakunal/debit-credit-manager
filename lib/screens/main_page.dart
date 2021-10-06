import 'package:debit_credit/screens/addition_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addTransaction,
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text("HOME"),
        ),
      ),
    );
  }
}
