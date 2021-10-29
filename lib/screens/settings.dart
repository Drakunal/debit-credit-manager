import 'package:debit_credit/shared/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Color colorR = HexColor("#0000FF"); //make it white later on

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getColorValue();
  }

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
    Color green = HexColor("00FF00");
    setState(() {
      if (colorR == blue) {
        colorR = violet;
        setColorValue("#8F00FF");
      } else if (colorR == violet) {
        colorR = green;
        setColorValue("00FF00");
      } else {
        colorR = blue;
        setColorValue("#8F00FF");
      }
    });
  }

  setColorValue(String hexCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('colorName', hexCode);
  }

  getColorValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedColor = prefs.getString('colorName') ?? '#000000';
    setState(() {
      colorR = HexColor(savedColor);
    });
    return savedColor;
  }
}
