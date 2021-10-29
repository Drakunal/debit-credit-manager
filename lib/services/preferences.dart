import 'package:debit_credit/shared/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static String savedColorOriginal = '#000000';
  getColor(String paramColorOriginal) {
    // String hexColor = getColorValue() ?? '';
    getColorValue(paramColorOriginal);

    Color color = HexColor(savedColorOriginal);
    print('From 1 $savedColorOriginal');
    return color;
  }

  getColorValue(String paramColorOriginal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedColor = prefs.getString('colorName') ?? '#FFC0CB';
    savedColorOriginal = savedColor;
    print('From 2 $savedColorOriginal');
  }
}
