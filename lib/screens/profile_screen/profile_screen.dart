import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deal_hub/screens/profile_screen/profile_widgets/build_action_card.dart';
import 'package:deal_hub/screens/profile_screen/profile_widgets/build_menu_Item.dart';
import 'package:deal_hub/screens/profile_screen/profile_widgets/build_section.dart';
import 'package:deal_hub/controllers/profile_controller.dart';
import 'package:deal_hub/screens/profile_screen/personal_details_screen.dart';
import 'package:deal_hub/services/firestore_services.dart';
import '../../theme/theme.dart';
import '../../controllers/auth_controller.dart';
import '../authentication/change_password_screen.dart';
import '../cart_screen/my_order_screen.dart';
import '../help_suppor_about/about_screen.dart';
import '../help_suppor_about/help_and_support_screen.dart';
import '../notifications_scrren/notifications_screen.dart';
import '../onboarding_screen.dart';
import '../setting/choose_language_screen.dart';
import '../wish_list_screen/wish_list_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    var controller = Get.find<ProfileController>();
    var currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppTheme.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    left: -50,
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
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(() => PersonalDetailsScreen());
                          },
                          icon: Icon(Icons.more_vert, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
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
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.primaryColor),
                              ),
                            );
                          }
                          var data = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: data['profileImage'] != null && data['profileImage'].toString().isNotEmpty
                                      ? Image.network(
                                    data['profileImage'],
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
                              SizedBox(height: 16),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${data['name']}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Tooltip(
                                    message: 'Verified account',
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.verified,
                                        color: AppTheme.success,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${data['email']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),
                    StreamBuilder(
                        stream: FirestorServices.getUser(currentUser!.uid),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error: ${snapshot.error}"),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.primaryColor),
                              ),
                            );
                          }
                          var data = snapshot.data!.docs[0];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                buildActionCard(
                                  icon: Icons.shopping_bag_outlined,
                                  title: 'Orders',
                                  value: "${data['order_count'] ?? '00'}",
                                  color: AppTheme.primaryColor,
                                ),
                                SizedBox(width: 12),
                                buildActionCard(
                                  icon: Icons.favorite_border_outlined,
                                  title: 'Wishlist',
                                  value: "${data['wishlist_count'] ?? '00'}",
                                  color: AppTheme.secondaryColor,
                                ),
                                SizedBox(width: 12),
                                buildActionCard(
                                  icon: Icons.local_shipping_outlined,
                                  title: 'Shipping',
                                  value: "${data['shipping_count'] ?? '00'}",
                                  color: AppTheme.tertiaryColor,
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          buildSection(
                            title: "Shopping Preferences",
                            items: [
                              buildMenuItem(
                                icon: Icons.shopping_bag_outlined,
                                title: 'My Orders',
                                subtitle: "View your order history",
                                onTap: () {
                                  Get.to(() => MyOrderScreen());
                                },
                                color: AppTheme.secondaryColor,
                              ),
                              buildMenuItem(
                                icon: Icons.bookmarks_outlined,
                                title: 'Wishlist',
                                subtitle: "View your wishlists",
                                onTap: () {
                                  Get.to(() => WishListScreen());
                                },
                                color: AppTheme.secondaryColor,
                              ),
                              buildMenuItem(
                                icon: Icons.location_on_outlined,
                                title: 'Shipping Address',
                                subtitle: "Manage your delivery addresses",
                                onTap: () {},
                                color: AppTheme.secondaryColor,
                              ),
                              buildMenuItem(
                                icon: Icons.payment_outlined,
                                title: 'Payment Methods',
                                subtitle: "Manage your payment options",
                                onTap: () {},
                                color: AppTheme.secondaryColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          buildSection(
                            title: "Account Settings",
                            items: [
                              buildMenuItem(
                                icon: Icons.person_outline,
                                title: 'Personal Details',
                                subtitle: "Update your personal information",
                                onTap: () {
                                  Get.to(() => PersonalDetailsScreen());
                                },
                                color: AppTheme.primaryColor,
                              ),
                              buildMenuItem(
                                icon: Icons.lock_outline,
                                title: 'Change Password',
                                subtitle: "Update your password",
                                onTap: () {
                                  Get.to(() => ChangePasswordScreen());
                                },
                                color: AppTheme.primaryColor,
                              ),
                              buildMenuItem(
                                icon: Icons.notifications,
                                title: 'Notifications',
                                subtitle: "Manage your notifications",
                                onTap: () {
                                  Get.to(() => NotificationsScreen());
                                },
                                color: AppTheme.primaryColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          buildSection(
                            title: "More",
                            items: [
                              buildMenuItem(
                                icon: Icons.settings_outlined,
                                title: 'Settings',
                                subtitle: "App settings and preferences",
                                onTap: () {
                                  Get.to(() => ChooseLanguageScreen());
                                },
                                color: AppTheme.tertiaryColor,
                              ),
                              buildMenuItem(
                                icon: Icons.help_outline,
                                title: 'Help & Support',
                                subtitle: "Get help and support",
                                onTap: () {
                                  Get.to(() => HelpAndSupportScreen());
                                },
                                color: AppTheme.tertiaryColor,
                              ),
                              buildMenuItem(
                                icon: Icons.error_outline,
                                title: 'About',
                                subtitle: "Get to Know Us!",
                                onTap: () {
                                  Get.to(() => AboutScreen());
                                },
                                color: AppTheme.tertiaryColor,
                              ),
                              buildMenuItem(
                                icon: Icons.logout,
                                title: 'Logout',
                                subtitle: "Sign out of your account",
                                onTap: () async {
                                  await Get.find<AuthController>()
                                      .signoutMethod(context);
                                  Get.offAll(() => OnboardingScreen());
                                },
                                color: AppTheme.error,
                                isDestructive: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Text(
                            "Version 1.0.0",
                            style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "© Anayat Hossain All rights reserved.",
                            style: TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}