import 'package:debit_credit/shared/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color colorR = HexColor("#0000FF");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: colorR,
            ),
            ElevatedButton(onPressed: changeColor, child: Text("Change Color"))
          ],
        ),
      )),
    );
  }

  void changeColor() {
    Color violet = HexColor("#8F00FF");
    Color blue = HexColor("#0000FF");
    setState(() {
      if (colorR == blue) {
        colorR = violet;
        setColorValue("#8F00FF");
      } else {
        colorR = blue;
        setColorValue("#0000FF");
      }
    });
  }

  setColorValue(String hexCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('colorName', hexCode);
  }
}
