import 'package:debit_credit/screens/home.dart';
import 'package:debit_credit/screens/signin.dart';
import 'package:debit_credit/screens/wrapper.dart';
import 'package:debit_credit/services/authenticate.dart';
import 'package:debit_credit/services/preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //when using shared prefs and firebase
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int size = Preference().getFontSize();

  // final user = FirebaseAuth.instance.currentUser!;

  await Firebase.initializeApp();
  runApp(App());
  // StreamProvider<User>.value(value: null, initialData: user, child: App()));
}

class App extends StatelessWidget {
  int size = Preference().getFontSize();
  // const App({Key? key}) : super(key: key);
  // int size;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => Authenticate(),
        child: MaterialApp(
          theme: ThemeData(
            textTheme: TextTheme(
              overline: TextStyle(
                fontSize: Preference().getFontSize().toDouble(),
              ),
              caption: TextStyle(
                fontSize: Preference().getFontSize().toDouble(),
              ),
              button: TextStyle(
                fontSize: Preference().getFontSize().toDouble(),
              ),
              // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(
                  fontSize: (Preference().getFontSize() + 5).toDouble()),
              // headline1: TextStyle(fontSize: size.toDouble()),
              // headline3: TextStyle(fontSize: size.toDouble()),
              // headline2: TextStyle(fontSize: size.toDouble()),
              // headline4: TextStyle(fontSize: size.toDouble()),
              // headline5: TextStyle(fontSize: size.toDouble()),
              subtitle1:
                  TextStyle(fontSize: Preference().getFontSize().toDouble()),
              // subtitle2: TextStyle(fontSize: size.toDouble()),
              bodyText1: TextStyle(
                fontSize: Preference().getFontSize().toDouble(),
                //  fontFamily: 'Hind'
              ),
              bodyText2: TextStyle(
                fontSize: Preference().getFontSize().toDouble(),
                //  fontFamily: 'Hind'
              ),
            ),
          ),
          home: Wrapper(),
        ),
      );
}
