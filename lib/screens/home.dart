import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:debit_credit/screens/main_page.dart';
import 'package:debit_credit/screens/profile.dart';
import 'package:debit_credit/screens/settings.dart';
import 'package:debit_credit/services/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  int _page = 1;
  final screens = [Profile(), MainPage(), Settings()];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Savings++"),
        actions: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    final provider =
                        Provider.of<Authenticate>(context, listen: false);
                    provider.logout();
                  },
                  child: Row(
                    children: [
                      Text("Logout ", style: TextStyle(color: Colors.white)),
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      )
                    ],
                  )),
            ],
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        color: Colors.blue,
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
    );
  }

  void _a() {}
}
