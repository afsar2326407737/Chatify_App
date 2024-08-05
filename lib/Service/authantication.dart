import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // for storing data in cloud
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

// for signup
  Future<String> signup(
      {required String email,
      required String password,
      required String name}) async {
    String res = "some error occured";
    try {
      // for user
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // sdding the user to cloud fire storage
      await _firestore.collection("users").doc(credential.user!.uid).set({
        'name': name,
        'email': email,
        'uid': credential.user!.uid,
      });
      res = 'success';
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty || password.isEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Enter and check the all credentails ";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }
}
