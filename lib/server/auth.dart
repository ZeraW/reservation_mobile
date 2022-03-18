import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/user.dart';
import 'database_api.dart';
import 'firebase/user_api.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserModel _userFromFirebaseUser(User user) {
    return UserModel(id: user.uid);
  }

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No user found for that Email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Wrong password provided for that user.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      {required UserModel newUser}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: '${newUser.email}', password: newUser.password!);

      User fbUser = result.user!;
      newUser.id = fbUser.uid;
      await UserApi().updateUserData(user: newUser);

      return _userFromFirebaseUser(fbUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "The password provided is too weak.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changePassword(String? password, Function() fun) async {
    if (password == null) {
      fun();
    } else {
      //Create an instance of the current user.
      final user = _auth.currentUser;
      //Pass in the password to updatePassword.
      user!.updatePassword(password).then((_) {
        debugPrint("Successfully changed password");
        Fluttertoast.showToast(
            msg: "Successfully changed password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        fun();
      }).catchError((error) {
        debugPrint("Password can't be changed" + error.toString());
        Fluttertoast.showToast(
            msg: "Password can't be changed + ${error.toString()}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
