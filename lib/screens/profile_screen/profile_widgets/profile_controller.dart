import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:velocity_x/velocity_x.dart';

class ProfileController extends GetxController {
  var profileImgPath = "".obs;
  var profileImgUrl = "".obs;

  // Function to change image
  Future<void> changeImage(context) async {
    try {
      print("Picking image from gallery...");
      final XFile? img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70, // Reduce image quality for faster upload
      );

      if (img != null) {
        print("Image picked: ${img.path}");
        profileImgPath.value = img.path;
        await uploadImageToFirebase(File(img.path)); // Upload image to Firebase
      } else {
        print("No image selected.");
      }
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
      VxToast.show(context, msg: "Failed to pick an image: ${e.message}");
    } catch (e) {
      print("Unexpected error: $e");
      VxToast.show(context, msg: "Unexpected error: $e");
    }
  }

  // Function to upload image to Firebase Storage
  Future<void> uploadImageToFirebase(File image) async {
    try {
      // Check if the file exists
      if (!image.existsSync()) {
        print("Image file does not exist: ${image.path}");
        return;
      }

      // Generate a unique filename
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // Reference to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/$fileName.jpg');

      // Upload the file
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      // Update Firestore with the new image URL
      await updateUserProfileImage(downloadURL);

      // Update local state
      profileImgUrl.value = downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  // Function to update user profile image in Firestore
  Future<void> updateUserProfileImage(String imageUrl) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId);

      // Check if the document exists
      DocumentSnapshot userDoc = await userDocRef.get();
      if (userDoc.exists) {
        await userDocRef.update({'imageUrl': imageUrl});
      } else {
        await userDocRef.set({'imageUrl': imageUrl});
      }
    } catch (e) {
      print("Error updating Firestore: $e");
    }
  }

  // Function to load user data from Firestore
  Future<void> loadUserData() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        profileImgUrl.value = userDoc['imageUrl'] ?? '';
        // Load other fields if needed
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  // Function to reset image
  void resetImage() {
    profileImgPath.value = "";
    profileImgUrl.value = "";
  }
}