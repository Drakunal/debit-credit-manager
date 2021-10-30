import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:debit_credit/screens/main_page.dart';
import 'package:debit_credit/screens/profile.dart';
import 'package:debit_credit/screens/settings.dart';
import 'package:debit_credit/services/authenticate.dart';
import 'package:debit_credit/services/database.dart';
import 'package:debit_credit/services/preferences.dart';
import 'package:debit_credit/shared/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart' as s;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  String savedColorOriginal = '#FFFF00';
  int _page = 1;
  final screens = [Profile(), MainPage(), Settings()];
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Preference().getColor(),
        title: Text("Savings++", style: TextStyle(color: Colors.black)),
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
                      Text("Logout ", style: TextStyle(color: Colors.black)),
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      )
                    ],
                  )),
            ],
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 500),
        height: 65,
        index: 1,
        key: _bottomNavigationKey,
        backgroundColor: Colors.white.withOpacity(0),
        color: getColor(), //not working with pref.getColor
        items: [
          Icon(Icons.person_rounded, size: 30),
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
}
