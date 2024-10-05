import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  //for storing data in the cloud
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //for authentication in flutter
  final FirebaseAuth _auth = FirebaseAuth.instance;

//for sign up
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String name}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // for adding user to our firestore
        await _firestore.collection("users").doc(credential.user!.uid).set({
          "name": name,
          "email": email,
          "uid": credential.user!.uid
          // we can not store the password on the cloud
        });
        res = "Successfull";
      } // for registering user in the firebase auth with emial and password
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //login user with email and password
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "sucess";
      } else {
        res = "Please enter all field";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
