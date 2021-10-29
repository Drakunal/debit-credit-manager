import 'package:debit_credit/services/preferences.dart';
import 'package:debit_credit/shared/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _fontSizeValue = 10;
  Color colorR = HexColor("#0000FF"); //make it white later on

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorR = Preference().getColor();
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
            Spacer(),
            CircleAvatar(
              backgroundColor: colorR,
            ),
            ElevatedButton(onPressed: changeColor, child: Text("Change Color")),
            Spacer(),
            Slider(
                value: Preference()
                    .getFontSize()
                    .toDouble(), // cannot be a constant value
                min: 10,
                max: 20,
                // activeColor: _text_color,
                // inactiveColor: _text_color.withOpacity(.4),
                divisions: 9,
                label: _fontSizeValue.toString(),
                onChanged: (double newValue) {
                  print(newValue.round());
                  setState(() {
                    _fontSizeValue = newValue.round();
                    Preference().setFontSizeValue(_fontSizeValue);
                  });
                }),
            Spacer(),
          ],
        ),
      )),
    );
  }

  void changeColor() {
    Color violet = HexColor("#8F00FF");
    Color yellow = HexColor("#FFFF00");
    Color green = HexColor("00FF00");
    setState(() {
      if (colorR == yellow) {
        colorR = violet;
        Preference().setColorValue("#8F00FF");
      } else if (colorR == violet) {
        colorR = green;
        Preference().setColorValue("00FF00");
      } else {
        colorR = yellow;
        Preference().setColorValue("#FFFF00");
      }
    });
  }

  // setColorValue(String hexCode) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('colorName', hexCode);
  // }

  // getColorValue() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String savedColor = prefs.getString('colorName') ?? '#000000';
  //   setState(() {
  //     colorR = HexColor(savedColor);
  //   });
  //   return savedColor;
  // }

  void changeFont(double value) {
    print(value);
  }
}
