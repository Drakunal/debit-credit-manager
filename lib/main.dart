import 'package:debit_credit/screens/home.dart';
import 'package:debit_credit/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: SignIn(),
  ));
}
