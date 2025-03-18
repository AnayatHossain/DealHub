import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: FirebaseOptions(
    //     apiKey: "AIzaSyDFHLmbPqsOK4UHRklSoXSNXC78ZbidyYQ",
    //     projectId: "dealhub-b6f03",
    //     messagingSenderId: "227342535608",
    //     appId: "1:227342535608:web:e7bcfd0237d85fa646dd4d",
    // ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    )
  );
  runApp(DealHub());
}
