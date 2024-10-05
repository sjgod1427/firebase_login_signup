import 'package:firebase_login_signup/Login_Signup/Screens/login.dart';
import 'package:firebase_login_signup/Login_Signup/Services/authentication.dart';
import 'package:firebase_login_signup/Login_Signup/Widgets/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Congratulations have Successfully Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          const SizedBox(height: 20),
          MyButton(
              onTab: () async {
                await AuthServices().signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              text: "Log out")
        ],
      )),
    );
  }
}
