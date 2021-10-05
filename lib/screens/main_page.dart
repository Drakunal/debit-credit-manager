import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text("HOME"),
          // child: Column(
          //   // children: <Widget>[
          //   //   Text(_page.toString(), textScaleFactor: 10.0),
          //   //   // ElevatedButton(
          //   //   //   child: Text('Go To Page of index 1'),
          //   //   //   // onPressed: () {
          //   //   //   //   //Page change using state does the same as clicking index 1 navigation button
          //   //   //   //   final CurvedNavigationBarState? navBarState =
          //   //   //   //       _bottomNavigationKey.currentState;
          //   //   //   //   navBarState?.setPage(1);
          //   //   //   // },
          //   //   // )
          //   // ],
          // ),
        ),
      ),
    );
  }
}
