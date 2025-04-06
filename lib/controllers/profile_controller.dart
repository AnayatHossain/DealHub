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
  var profileImgUrl = "".obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      var userId = _auth.currentUser?.uid;
      if (userId == null) return;

      var userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        profileImgPath.value = userDoc['profileImage'] ?? "";
        profileImgUrl.value = userDoc['profileImage'] ?? "";
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }

  Future<void> changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (img != null) {
        profileImgPath.value = img.path;
        update();
      }
    } on PlatformException catch (e) {
      VxToast.show(context, msg: "Failed to pick image: ${e.message}");
    } catch (e) {
      VxToast.show(context, msg: "Unexpected error: $e");
    }
  }

  Future<void> uploadProfileImage(File imageFile) async {
    try {
      isLoading(true);
      var userId = _auth.currentUser?.uid;
      if (userId == null) return;

      var ref = _storage.ref().child("profileImages/$userId.jpg");
      var uploadTask = await ref.putFile(imageFile);
      var downloadUrl = await uploadTask.ref.getDownloadURL();

      await _firestore.collection('users').doc(userId).update({
        'profileImage': downloadUrl,
      });

      profileImgPath.value = downloadUrl;
      profileImgUrl.value = downloadUrl;
      update();
    } catch (e) {
      print("Error uploading profile image: $e");
    } finally {
      isLoading(false);
    }
  }

  updateProfile(name, email, phone, dob, gender, imgUrl) async {
    try {
      isLoading(true);
      var store = _firestore.collection('users').doc(_auth.currentUser!.uid);
      await store.set({
        'name': name,
        'email': email,
        'phone': phone,
        'dob': dob,
        'gender': gender,
        'profileImage': imgUrl,
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updating profile: $e");
    } finally {
      isLoading(false);
    }
  }
}