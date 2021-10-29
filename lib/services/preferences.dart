import 'package:debit_credit/shared/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static String savedColorOriginal = '#000000';
  getColor() {
    // String hexColor = getColorValue() ?? '';
    getColorValue();

    Color color = HexColor(savedColorOriginal);
    print('From 1 $savedColorOriginal');
    return color;
  }

  getColorValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedColor = prefs.getString('colorName') ?? '#FFC0CB';
    savedColorOriginal = savedColor;
    print('From 2 $savedColorOriginal');
  }

  setColorValue(String hexCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('colorName', hexCode);
  }
}
