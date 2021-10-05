import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Center(
        child: Column(
          children: [
            Spacer(),
            Text("PROFILE"),
            Spacer(),
            Image(image: NetworkImage(user.photoURL!)),
            Spacer(),
            Text("Name: " + user.displayName!),
            Spacer(),
            Text("Email: " + user.email!),
            Spacer(),
          ],
        ),
      )),
    );
  }
}
