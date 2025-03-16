import 'package:deal_hub/screens/main_screen.dart';
import 'package:deal_hub/screens/setting/choose_language_screen.dart';
import 'package:deal_hub/screens/splash_screen.dart';
import 'package:deal_hub/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealHub extends StatelessWidget {
  const DealHub({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DealHub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: SplashScreen(),

    );
  }
}
