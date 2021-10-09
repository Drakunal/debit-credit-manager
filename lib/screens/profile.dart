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
      body: Center(
        child: Column(
          children: [Spacer(), _getAvatar(), _getCard(), Spacer()],
        ),
      ),
    );
    // return Card(
    //   // color: Colors.black,
    //   child: Center(
    //     child: Column(
    //       children: [
    //         Spacer(),
    //         CircleAvatar(
    //           backgroundColor: Colors.blue,
    //           radius: MediaQuery.of(context).size.width * 0.12,
    //           child: Container(
    //             width: MediaQuery.of(context).size.width * 0.24,
    //             height: MediaQuery.of(context).size.width * 0.24,
    //             child: Center(
    //               child: Text(
    //                 user.displayName.toString()[0],
    //                 style: TextStyle(
    //                     fontSize: MediaQuery.of(context).size.width * 0.1,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             decoration: BoxDecoration(
    //                 image: DecorationImage(
    //                   image: NetworkImage(user.photoURL!),
    //                   fit: BoxFit.contain,
    //                 ),
    //                 borderRadius: BorderRadius.circular(
    //                   MediaQuery.of(context).size.width * 0.12,
    //                 )),
    //           ),
    //         ),
    //         Image(
    //           image: NetworkImage(user.photoURL!),
    //           fit: BoxFit.cover,
    //         ),
    //         Spacer()
    //       ],
    //     ),
    //   ),
    // );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Container(
    //       child: Center(
    //     child: Column(
    //       children: [
    //         Spacer(),
    //         Text("PROFILE"),
    //         Spacer(),
    //         // CircleAvatar(
    //         //   backgroundColor: Colors.amberAccent,
    //         //   child: Container(
    //         //     // width: 100,
    //         //     // height: 100,
    //         //     decoration: BoxDecoration(
    //         //         image: DecorationImage(
    //         //             scale: 0.5,
    //         //             image: NetworkImage(user.photoURL!),
    //         //             fit: BoxFit.cover),
    //         //         borderRadius: BorderRadius.circular(50)),
    //         //     child: null,
    //         //   ),
    //         // ),
    //         Image(image: NetworkImage(user.photoURL!)),
    //         Spacer(),
    //         Text("Name: " + user.displayName!),
    //         Spacer(),
    //         Text("Email: " + user.email!),
    //         Spacer(),
    //       ],
    //     ),
    //   )),
    // );
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: Colors.blueAccent, width: 2),
          image: DecorationImage(
              image: NetworkImage(user.photoURL!), fit: BoxFit.cover)),
    );
  }

  Container _getCard() {
    return Container(
        width: 350,
        height: 200,
        margin: EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.displayName.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(user.email.toString(),
                style: TextStyle(fontStyle: FontStyle.italic)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.computer),
              ],
            )
          ],
        ));
  }
}
