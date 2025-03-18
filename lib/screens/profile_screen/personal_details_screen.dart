import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:deal_hub/controllers/profile_controller.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../services/firestore_services.dart';
import '../../theme/theme.dart';
import 'edit_personal_details_screen.dart';

class PersonalDetailsScreen extends StatelessWidget {
  PersonalDetailsScreen({super.key});

  var currentUser = FirebaseAuth.instance.currentUser;
  var controller = Get.find<ProfileController>();

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: AppTheme.primaryColor),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: valueColor ?? AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                          'Personal Details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(() => EditPersonalDetailsScreen());
                        },
                        icon: Icon(Icons.edit, color: Colors.white),
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
                    child: StreamBuilder(
                      stream: FirestorServices.getUser(currentUser!.uid),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.primaryColor),
                            ),
                          );
                        }

                        var data = snapshot.data!.docs[0];

                        // ✅ Function to convert Timestamp to formatted string
                        String formatDate(dynamic timestamp) {
                          if (timestamp is Timestamp) {
                            return DateFormat('dd MMM yyyy')
                                .format(timestamp.toDate());
                          }
                          return "N/A";
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 5),
                              child: Container(
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
                                  child: Obx(() {
                                    if (controller
                                        .profileImgPath.value.isNotEmpty) {
                                      return Image.file(
                                        File(controller.profileImgPath.value),
                                        fit: BoxFit.cover,
                                      );
                                    } else {
                                      return Image.asset(
                                          'assets/images/profile.JPG');
                                    }
                                  }),
                                ),
                              ),
                            ),
                            _buildSection(
                              "Personal Information",
                              [
                                _buildInfoRow(
                                  icon: Icons.badge,
                                  label: "Full Name",
                                  value: data['name'] ?? "N/A",
                                ),
                                _buildInfoRow(
                                  icon: Icons.email,
                                  label: "Email",
                                  value: data['email'] ?? "N/A",
                                ),
                                _buildInfoRow(
                                  icon: Icons.phone,
                                  label: "Phone",
                                  value: data['phone'] ?? "N/A",
                                ),
                              ],
                            ),
                            _buildSection(
                              "More Information",
                              [
                                _buildInfoRow(
                                  icon: Icons.calendar_today,
                                  label: "Date of Birth",
                                  value: formatDate(data['dob'] ?? "N/A"),
                                ),
                                _buildInfoRow(
                                  icon: Icons.person,
                                  label: "Gender",
                                  value: data['gender'] ?? "N/A",
                                ),
                              ],
                            ),
                            _buildSection(
                              "Personal Information",
                              [
                                _buildInfoRow(
                                  icon: Icons.calendar_month,
                                  label: "Member Since",
                                  value: formatDate(data['memberSince']),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
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
