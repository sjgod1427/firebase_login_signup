import 'package:firebase_login_signup/Login_Signup/Screens/home_screen.dart';
import 'package:firebase_login_signup/Login_Signup/Screens/login.dart';
import 'package:firebase_login_signup/Login_Signup/Services/authentication.dart';
import 'package:flutter/material.dart';

import '../Widgets/button.dart';
import '../Widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  void signUpUser() async {
    String res = await AuthServices().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    if (res == 'success') {
      setState(() {
        isLoading = true;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      height: height / 2.8,
                      child: Image.asset("images/signup.jpeg")),
                  TextFieldInput(
                      textEditingCOntroller: nameController,
                      icon: Icons.person,
                      hinttext: "Enter Your Name"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(
                      textEditingCOntroller: emailController,
                      icon: Icons.email,
                      hinttext: "Enter Your Email"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(
                      textEditingCOntroller: passwordController,
                      icon: Icons.lock,
                      isPass: true,
                      hinttext: "Enter Your Password"),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                  MyButton(onTab: signUpUser, text: "Sign  Up"),
                  SizedBox(
                    height: height / 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have An Account ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
