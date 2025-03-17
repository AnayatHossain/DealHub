import 'package:deal_hub/widgets/custom_text_field.dart';
import 'package:deal_hub/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';

class EditUserDetailsScreen extends StatefulWidget {
  const EditUserDetailsScreen({super.key});

  @override
  State<EditUserDetailsScreen> createState() => _EditUserDetailsScreenState();
}

class _EditUserDetailsScreenState extends State<EditUserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController(text: "Anayat");
  final _lastNameController = TextEditingController(text: "Hossain");
  final _emailController =
      TextEditingController(text: "anayathossain@admin.com");
  final _phoneController = TextEditingController(text: "+88017123456789");
  final _dobController = TextEditingController(text: "03 January, 1998");
  String _selectedGender = 'Male';

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
                          'Edit User Details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
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
                                  child:
                                      Image.asset('assets/images/profile.JPG'),
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
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppTheme.primaryColor,
                                    size: 20,
                                  ),
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
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value == null) {
                                              return 'Please enter your first name';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: _lastNameController,
                                          label: "Last Name",
                                          prefixIcon: Icons.person,
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value == null) {
                                              return 'Please enter your last name';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 16),
                                  CustomTextField(
                                    controller: _emailController,
                                    label: "Email",
                                    prefixIcon: Icons.email,
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(width: 16),
                                  CustomTextField(
                                    controller: _phoneController,
                                    label: "Phone",
                                    prefixIcon: Icons.phone,
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return 'Please enter your phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(width: 20),
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
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return 'Please enter date of birth';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: AppTheme.primaryColor,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8), // Add padding for better spacing
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly space the radio buttons
                                            children: [
                                              Row(
                                                children: [
                                                  Radio<String>(
                                                    value: 'Male',
                                                    groupValue: _selectedGender,
                                                    activeColor: AppTheme.primaryColor,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _selectedGender = value!;
                                                      });
                                                    },
                                                  ),
                                                  Text("Male"),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio<String>(
                                                    value: 'Female',
                                                    groupValue: _selectedGender,
                                                    activeColor: AppTheme.primaryColor,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _selectedGender = value!;
                                                      });
                                                    },
                                                  ),
                                                  Text("Female"),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio<String>(
                                                    value: 'Other',
                                                    groupValue: _selectedGender,
                                                    activeColor: AppTheme.primaryColor,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        _selectedGender = value!;
                                                      });
                                                    },
                                                  ),
                                                  Text("Other"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
