import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileController extends GetxController {
  var profileImgPath = "".obs;
  var profileImgUrl = "".obs; // Stores the profile image URL from Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  // Fetch user profile data from Firestore
  Future<void> fetchUserProfile() async {
    try {
      var userId = _auth.currentUser?.uid;
      if (userId == null) return;

      var userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        profileImgPath.value = userDoc['profileImgPath'] ?? "";
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }

  // Function to change image
  Future<void> changeImage(context) async {
    try {
      final XFile? img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (img != null) {
        profileImgPath.value = img.path;
        update(); // Notify UI about changes

        // Upload to Firebase Storage and update Firestore
        await uploadProfileImage(File(img.path));
      }
    } on PlatformException catch (e) {
      VxToast.show(context, msg: "Failed to pick an image: ${e.message}");
    } catch (e) {
      VxToast.show(context, msg: "Unexpected error: $e");
    }
  }

  // Function to reset image
  void resetImage() {
    profileImgPath.value = "";
    update(); // Notify UI
  }

  // Function to upload profile image to Firebase Storage and update Firestore
  Future<void> uploadProfileImage(File imageFile) async {
    try {
      var userId = _auth.currentUser?.uid;
      if (userId == null) return;

      // Upload to Firebase Storage
      var ref = _storage.ref().child("profileImages/$userId.jpg");
      var uploadTask = await ref.putFile(imageFile);
      var downloadUrl = await uploadTask.ref.getDownloadURL();

      // Update Firestore with new image URL
      await _firestore.collection('users').doc(userId).update({
        'profileImage': downloadUrl,
      });

      profileImgUrl.value = downloadUrl; // Update local variable
      update(); // Notify UI
    } catch (e) {
      print("Error uploading profile image: $e");
    }
  }
}