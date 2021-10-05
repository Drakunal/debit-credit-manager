import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:debit_credit/screens/main_page.dart';
import 'package:debit_credit/screens/profile.dart';
import 'package:debit_credit/screens/settings.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 1;
  final screens = [Profile(), MainPage(), Settings()];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Savings++"),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        color: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.account_circle_outlined, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: screens[_page],
      // body: Container(
      //   color: Colors.red,
      //   child: Center(
      //     child: Column(
      //       children: <Widget>[
      //         Text(_page.toString(), textScaleFactor: 10.0),
      //         ElevatedButton(
      //           child: Text('Go To Page of index 1'),
      //           onPressed: () {
      //             //Page change using state does the same as clicking index 1 navigation button
      //             final CurvedNavigationBarState? navBarState =
      //                 _bottomNavigationKey.currentState;
      //             navBarState?.setPage(1);
      //           },
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
