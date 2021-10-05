import 'package:debit_credit/screens/home.dart';
import 'package:debit_credit/screens/signin.dart';
import 'package:debit_credit/services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => Authenticate(),
        child: MaterialApp(
          home: SignIn(),
        ),
      );
}
