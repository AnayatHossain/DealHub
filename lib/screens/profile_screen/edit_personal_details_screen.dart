import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:deal_hub/controllers/profile_controller.dart';
import 'package:deal_hub/widgets/custom_text_field.dart';
import 'package:deal_hub/theme/theme.dart';
import 'package:intl/intl.dart';

class EditPersonalDetailsScreen extends StatefulWidget {
  const EditPersonalDetailsScreen({super.key});

  @override
  State<EditPersonalDetailsScreen> createState() => _EditPersonalDetailsScreenState();
}

class _EditPersonalDetailsScreenState extends State<EditPersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  var controller = Get.find<ProfileController>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  String _selectedGender = 'None';

  var currentUser = FirebaseAuth.instance.currentUser;
  bool _isSaving = false;// To track if the save operation is in progress

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    var userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
    if (userDoc.exists) {
      var data = userDoc.data() as Map<String, dynamic>;

      // Split the full name into first name and last name
      String fullName = data['name'] ?? '';
      List<String> nameParts = fullName.split(' ');

      String firstName = nameParts.isNotEmpty ? nameParts.first : '';
      String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      setState(() {
        _firstNameController.text = firstName; // Set first name
        _lastNameController.text = lastName;  // Set last name
        _emailController.text = data['email'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _dobController.text = data['dob'] != null ? DateFormat('dd MMM yyyy').format((data['dob'] as Timestamp).toDate()) : '';
        _selectedGender = data['gender'] ?? 'None';
      });
    }
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSaving = true; // Start the saving process
      });

      try {
        // Combine first name and last name into full name
        String fullName = '${_firstNameController.text} ${_lastNameController.text}';

        // Update the user data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).update({
          'name': fullName, // Save full name
          'email': _emailController.text,
          'phone': _phoneController.text,
          'dob': _dobController.text.isNotEmpty ? Timestamp.fromDate(DateFormat('dd MMM yyyy').parse(_dobController.text)) : null,
          'gender': _selectedGender,
        });

        // If the update is successful, navigate back
        Get.back();
      } catch (e) {
        // Handle any errors that occur during the update
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isSaving = false; // Stop the saving process
        });
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppTheme.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 48,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Expanded(
                        child: Text(
                          'Edit Personal Details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      _isSaving
                          ? CircularProgressIndicator(color: Colors.white) // Show loading indicator
                          : TextButton(
                        onPressed: _updateUserData,
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.12,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppTheme.primaryColor,
                                    width: 4,
                                  ),
                                  gradient: LinearGradient(
                                    colors: AppTheme.primaryGradient,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Obx(
                                        () => controller.profileImgPath.value.isNotEmpty
                                        ?  Image.file(
                                          File(controller.profileImgPath.value),
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.asset(
                                      'assets/images/profile.JPG',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppTheme.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: InkWell(
                                      onTap: () => controller.changeImage(context),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: AppTheme.primaryColor,
                                        size: 20,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            padding: EdgeInsets.all(5),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Personal Information",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: _firstNameController,
                                          label: "First Name",
                                          prefixIcon: Icons.person,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: _lastNameController,
                                          label: "Last Name",
                                          prefixIcon: Icons.person,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 16),
                                  CustomTextField(
                                    controller: _emailController,
                                    label: "Email",
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: Icons.email,
                                  ),
                                  SizedBox(width: 16),
                                  CustomTextField(
                                    controller: _phoneController,
                                    label: "Phone",
                                    prefixIcon: Icons.phone,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "More Information",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  CustomTextField(
                                    controller: _dobController,
                                    label: "Date of Birth",
                                    prefixIcon: Icons.calendar_today,
                                  ),
                                  SizedBox(height: 16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: ["Male", "Female", "Other"]
                                            .map((gender) => Row(
                                          children: [
                                            Radio<String>(
                                              value: gender,
                                              groupValue: _selectedGender,
                                              activeColor: AppTheme.primaryColor,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _selectedGender = value!;
                                                });
                                              },
                                            ),
                                            Text(gender),
                                          ],
                                        ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}