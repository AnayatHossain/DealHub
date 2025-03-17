import 'package:deal_hub/widgets/custom_text_field.dart';
import 'package:deal_hub/widgets/gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../theme/theme.dart';
import '../../widgets/social_login_button.dart';
import '../main_screen.dart';
import 'auth_controller.dart';
import 'firebase_const.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isCheck = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                          'Create Account',
                          style: TextStyle(
                            fontSize: 24,
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
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Container(
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
                      Text(
                        "Create your account",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Sign up to start your shopping journey",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(5),
                        child: Form(
                          key: _formKey,
                          child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 24),
                              CustomTextField(
                                controller: nameController,
                                label: "Full Name",
                                prefixIcon: Icons.person,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 8),
                              CustomTextField(
                                controller: emailController,
                                label: "Email",
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icons.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 8),
                              CustomTextField(
                                controller: passwordController,
                                label: "Password",
                                prefixIcon: Icons.lock,
                                keyboardType: TextInputType.visiblePassword,
                                isPassword: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 8),
                              CustomTextField(
                                controller: passwordConfirmController,
                                label: "Confirm Password",
                                prefixIcon: Icons.lock,
                                keyboardType: TextInputType.visiblePassword,
                                isPassword: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isCheck,
                                    onChanged: (value) {
                                      setState(() {
                                        isCheck = value!;
                                      });
                                    },
                                  ),
                                  Text("I agree to the terms and conditions"),
                                ],
                              ),
                              SizedBox(height: 20),
                              controller.isLoading.value
                                  ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(AppTheme.primaryColor),
                              )
                                  : GradientButton(
                                text: "Sign Up",
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() && isCheck) {
                                    controller.isLoading(true);
                                    if (passwordController.text == passwordConfirmController.text) {
                                      try {
                                        UserCredential? userCredential = await controller.signupMethod(
                                          emailController.text,
                                          passwordController.text,
                                          context,
                                          name: nameController.text,
                                        );

                                        if (userCredential != null) {
                                          await controller.storeUserData(
                                            nameController.text,
                                            emailController.text,
                                            passwordController.text,
                                          );

                                          VxToast.show(context, msg: "Logged in Successfully");
                                          Get.offAll(() => MainScreen());
                                        }
                                      } catch (e) {
                                        VxToast.show(context, msg: e.toString());
                                        await auth.signOut();
                                        controller.isLoading(false);
                                      }
                                    } else {
                                      VxToast.show(context, msg: "Passwords do not match!");
                                    }
                                  } else if (!isCheck) {
                                    VxToast.show(context, msg: "Please agree to the terms and conditions");
                                  }
                                },
                              ),
                              SizedBox(height: 24),
                              Center(
                                child: Text(
                                  "Or continue with",
                                  style: TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: SocialLoginButton(
                                      text: "Google",
                                      iconPath: 'assets/icons/google.png',
                                      onPressed: () {
                                        Get.offAll(() => MainScreen());
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: SocialLoginButton(
                                      text: "Apple",
                                      iconPath: 'assets/icons/apple.png',
                                      onPressed: () {
                                        Get.offAll(() => MainScreen());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => LoginScreen());
                                      },
                                      child: Text("Login"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   nameController.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   passwordConfirmController.dispose();
  //   super.dispose();
  // }
}