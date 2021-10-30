import 'package:debit_credit/services/preferences.dart';
import 'package:debit_credit/shared/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _fontSizeValue = Preference().getFontSize();
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
      backgroundColor: colorR.withAlpha(1),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              CircleAvatar(
                backgroundColor: colorR,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: changeColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Change Color"),
                  )),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Sample Text. Restart the app for the effect to take place",
                    style: TextStyle(fontSize: _fontSizeValue.toDouble())),
              ),
              Slider(
                  value: Preference()
                      .getFontSize()
                      .toDouble(), // cannot be a constant value
                  min: 10,
                  max: 24,
                  // activeColor: _text_color,
                  // inactiveColor: _text_color.withOpacity(.4),
                  divisions: 14,
                  label: _fontSizeValue.toString(),
                  onChanged: (double newValue) {
                    HapticFeedback.mediumImpact();
                    print(newValue.round());
                    setState(() {
                      _fontSizeValue = newValue.round();
                      Preference().setFontSizeValue(_fontSizeValue);
                    });
                  }),
              ElevatedButton(
                  onPressed: restart,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Restart App"),
                  )),
              Spacer(),
            ],
          ),
        ),
      )),
    );
  }

  void changeColor() {
    HapticFeedback.heavyImpact();
    Color violet = HexColor("#8F00FF");
    Color yellow = HexColor("#FFFF00");
    Color green = HexColor("00FF00");
    Color pink = HexColor("#FFC0CB");

    setState(() {
      if (colorR == yellow) {
        colorR = violet;
        Preference().setColorValue("#8F00FF");
      } else if (colorR == violet) {
        colorR = green;
        Preference().setColorValue("00FF00");
      } else if (colorR == green) {
        colorR = pink;
        Preference().setColorValue("#FFC0CB");
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

  void restart() {
    Restart.restartApp();
  }
}
