import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.black45),
  errorStyle: TextStyle(color: Colors.redAccent),
  border: OutlineInputBorder(),
  suffixIcon: Icon(Icons.money),
  labelText: 'Transaction amount',
);
