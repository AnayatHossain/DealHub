import 'package:deal_hub/controllers/auth_controller.dart';
import 'package:deal_hub/controllers/profile_controller.dart';
import 'package:deal_hub/screens/splash_screen.dart';
import 'package:deal_hub/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferences.getInstance(); // Initialize SharedPreferences
  runApp(const DealHub());
}

class DealHub extends StatelessWidget {
  const DealHub({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DealHub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => ProfileController());
        Get.put(AuthController());
      }),
    );
  }
}