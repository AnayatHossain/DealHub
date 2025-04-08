import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deal_hub/controllers/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../screens/authentication/firebase_const.dart';
import '../screens/onboarding_screen.dart';
import '../screens/authentication/new_password_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxString _verificationId = ''.obs;
  final RxString _emailForReset = ''.obs;

  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((User? user) {
      currentUser.value = user;
    });
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    } catch (e) {
      print('Error checking login status: $e');
    }
  }

  Future<void> _updateLoginState(bool loggedIn) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', loggedIn);
      isLoggedIn.value = loggedIn;
    } catch (e) {
      print('Error updating login state: $e');
      rethrow;
    }
  }

  // OTP Password Reset Methods
  Future<void> sendOtpToEmail(String email, BuildContext context) async {
    try {
      // In a real app, you would send an OTP via email service
      // For demo purposes, we'll just simulate this
      await auth.sendPasswordResetEmail(email: email);

      // Store the email for verification
      Get.find<AuthController>().setEmailForReset(email);

      Get.snackbar(
        "Success",
        "OTP sent to $email",
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "Failed to send OTP",
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  Future<void> verifyOtp(String otp, BuildContext context) async {
    try {
      // In a real app, you would verify the OTP with your backend
      // For demo purposes, we'll just check if it's 6 digits
      if (otp.length != 6) {
        throw "Invalid OTP";
      }

      Get.snackbar(
        "Success",
        "OTP verified successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  Future<void> updatePasswordAfterReset({
    required String email,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      // Find the user by email
      final methods = await auth.fetchSignInMethodsForEmail(email);
      if (methods.isEmpty) {
        throw "No user found with this email";
      }

      // In a real app, you would update the password through your backend
      // For demo purposes, we'll just simulate this
      final user = auth.currentUser;
      if (user != null && user.email == email) {
        await user.updatePassword(newPassword);
      }

      Get.snackbar(
        "Success",
        "Password updated successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  void setEmailForReset(String email) {
    // You can store this in your controller or use GetStorage/SharedPreferences
    // For simplicity, we're just storing it in the controller
    _emailForReset.value = email;
  }

  Future<UserCredential?> loginMethod(
      String email,
      String password,
      BuildContext context,
      ) async {
    try {
      isLoading(true);
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _updateLoginState(true);
      await Get.find<ProfileController>().fetchUserProfile();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? 'Login failed');
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<UserCredential?> signupMethod(
      String email,
      String password,
      BuildContext context, {
        required String name,
      }) async {
    try {
      isLoading(true);
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _updateLoginState(true);
      await storeUserData(name, email, password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? 'Signup failed');
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<void> storeUserData(String name, String email, String password) async {
    try {
      final user = auth.currentUser;
      if (user == null) throw 'No authenticated user';

      await firestore.collection(usersCollection).doc(user.uid).set({
        'name': name,
        'email': email,
        'password': password,
        'profileImage': '',
        'id': user.uid,
        'order_count': '00',
        'shipping_count': '00',
        'wishlist_count': '00',
        'phone': '',
        'dob': '',
        'gender': '',
        'memberSince': user.metadata.creationTime,
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error storing user data: $e');
      rethrow;
    }
  }

  Future<void> signoutMethod(BuildContext context) async {
    try {
      isLoading(true);
      await auth.signOut();
      await _updateLoginState(false);
      Get.offAll(() => OnboardingScreen());
    } catch (e) {
      Get.snackbar(
        "Logout Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      isLoading(true);
      final user = auth.currentUser;
      if (user == null) throw 'No authenticated user';

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      VxToast.show(
        context,
        msg: "Password changed successfully",
        bgColor: Colors.green,
        textColor: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      final message = _getPasswordChangeErrorMessage(e);
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

  String _getPasswordChangeErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
        return 'Current password is incorrect';
      case 'weak-password':
        return 'New password is too weak (min 6 characters)';
      default:
        return e.message ?? 'Failed to update password';
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}