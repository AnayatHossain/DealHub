import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import 'firebase_const.dart';

class AuthController extends GetxController {
  var isLoading= false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // Login
  Future<UserCredential?> loginMethod(context) async {
    UserCredential? userCredential;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message.toString());
      return userCredential;
    }
  }

  // Signup
  Future<UserCredential?> signupMethod(
      String email,
      String password,
      context, {
        required String name,
      }) async {
    UserCredential? userCredential;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user data after signup
      await storeUserData(name, email, password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message.toString());
      return userCredential;
    }
  }

  // Store user data
  Future<void> storeUserData(String name, String email, String password) async {
    try {
      DocumentReference store =
      firestore.collection(usersCollection).doc(auth.currentUser!.uid);
      await store.set({
        'name': name,
        'email': email,
        'password': password, // Consider hashing the password before storing
        'imageUrl': '',
        'id': auth.currentUser!.uid,
      });
    } catch (e) {
      print("Error storing user data: $e");
    }
  }

  // Sign out
  Future<void> signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }
}
