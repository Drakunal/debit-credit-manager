import 'package:debit_credit/shared/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static String savedColorOriginal = '#FFFF00';
  static int savedFontSizeOriginal = 12;
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
    savedColorOriginal = savedColor;
    // print('From 2 $savedColorOriginal');
  }

  setColorValue(String hexCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('colorName', hexCode);
  }

  getFontSize() {
    // String hexColor = getColorValue() ?? '';
    getFontSizeValue();

    // Color color = HexColor(savedColorOriginal);
    // print('From 1 $savedFontSizeOriginal');
    return savedFontSizeOriginal;
  }

  getFontSizeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tempSize = prefs.getInt('fontSizeValue') ?? 12;
    savedFontSizeOriginal = tempSize;
    // print('From 2 $savedFontSizeOriginal');
  }

  setFontSizeValue(int size) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('fontSizeValue', size);
  }
}
