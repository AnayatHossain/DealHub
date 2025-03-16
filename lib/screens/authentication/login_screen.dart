import 'package:deal_hub/screens/authentication/signup_screen.dart';
import 'package:deal_hub/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../main_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailError = ValueNotifier<String?>(null); // Track email error
    final _passwordError = ValueNotifier<String?>(null); // Track password error

    // Controllers for email and password fields
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensure the layout adjusts for the keyboard
      body: Column(
        children: [
          // Top Gradient Section
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppTheme.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: 48,
                  left: 16,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 48,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome Back',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Form Section
          Expanded(
            child: SingleChildScrollView( // Make the form scrollable
              padding: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login to your account",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Enter your credentials to continue shopping",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: 32),
                    // Email Field
                    CustomTextField(
                      label: "Email",
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController, // Pass the controller
                    ),
                    ValueListenableBuilder<String?>(
                      valueListenable: _emailError,
                      builder: (context, error, _) {
                        if (error == null) return SizedBox.shrink(); // No error
                        return Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            error,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    // Password Field
                    CustomTextField(
                      label: "Password",
                      prefixIcon: Icons.lock_outline,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: _passwordController, // Pass the controller
                    ),
                    ValueListenableBuilder<String?>(
                      valueListenable: _passwordError,
                      builder: (context, error, _) {
                        if (error == null) return SizedBox.shrink(); // No error
                        return Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            error,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => ForgotPasswordScreen());
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    GradientButton(
                      text: "Login",
                      onPressed: () {
                        // Clear previous errors
                        _emailError.value = null;
                        _passwordError.value = null;

                        // Validate email
                        final email = _emailController.text;
                        if (email.isEmpty) {
                          _emailError.value = 'Please enter your email';
                        } else if (!email.contains('@')) {
                          _emailError.value = 'Please enter a valid email';
                        }

                        // Validate password
                        final password = _passwordController.text;
                        if (password.isEmpty) {
                          _passwordError.value = 'Please enter your password';
                        } else if (password.length < 6) {
                          _passwordError.value =
                          'Password must be at least 6 characters';
                        }

                        // If no errors, proceed
                        if (_emailError.value == null &&
                            _passwordError.value == null) {
                          Get.offAll(() => MainScreen());
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
                              }),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: SocialLoginButton(
                              text: "Apple",
                              iconPath: 'assets/icons/apple.png',
                              onPressed: () {
                                // Get.to(() => CheckoutScreen());
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(() => SignUpScreen());
                              },
                              child: Text("Sign Up"))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}