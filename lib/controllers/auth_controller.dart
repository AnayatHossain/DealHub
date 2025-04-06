import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_hub/controllers/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import '../screens/authentication/firebase_const.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Login
  Future<UserCredential?> loginMethod(
      String email, String password, BuildContext context) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch profile data after login
      Get.find<ProfileController>().fetchUserProfile();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message.toString());
      return null;
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
        'profileImage': '', // Use 'profileImage' instead of 'imageUrl'
        'id': auth.currentUser!.uid,
        'order_count': '00',
        'shipping_count': '00',
        'wishlist_count': '00',
        'phone': '',
        'dob': '',
        'gender': '',
        'memberSince': auth.currentUser!.metadata.creationTime,
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

  // Password reset email
  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      VxToast.show(context, msg: "Password reset email sent to $email");
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message.toString());
      rethrow;
    }
  }

  // OTP verification
  Future<void> verifyPasswordReset(
      String email, String otp, BuildContext context) async {
    try {
      // In a real implementation, you would verify the OTP here
      // For demo purposes, we'll just confirm the email exists
      await auth.fetchSignInMethodsForEmail(email);
      VxToast.show(context, msg: "Password reset verified successfully");
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message.toString());
      rethrow;
    }
  }

  // NEW: Change password method
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      isLoading(true);
      final user = auth.currentUser;

      if (user == null) {
        throw 'No user is currently signed in';
      }

      // Reauthenticate user with their current password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update to new password
      await user.updatePassword(newPassword);

      VxToast.show(
        context,
        msg: "Password changed successfully",
        bgColor: Colors.green,
        textColor: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'wrong-password') {
        message = 'Current password is incorrect';
      } else if (e.code == 'weak-password') {
        message = 'New password is too weak (min 6 characters)';
      } else {
        message = e.message ?? 'Failed to update password';
      }

      VxToast.show(
        context,
        msg: message,
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      rethrow;
    } catch (e) {
      VxToast.show(
        context,
        msg: e.toString(),
        bgColor: Colors.red,
        textColor: Colors.white,
      );
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
