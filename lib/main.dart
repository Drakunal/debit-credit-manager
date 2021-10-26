import 'package:debit_credit/screens/home.dart';
import 'package:debit_credit/screens/signin.dart';
import 'package:debit_credit/screens/wrapper.dart';
import 'package:debit_credit/services/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final user = FirebaseAuth.instance.currentUser!;

  await Firebase.initializeApp();
  runApp(App());
  // StreamProvider<User>.value(value: null, initialData: user, child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => Authenticate(),
        child: MaterialApp(
          home: ShowCaseWidget(
            builder: Builder(builder: (_) => Wrapper()),
          ),
        ),
      );
}
