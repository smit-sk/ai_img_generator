import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logoipsum/Screen/home_screen.dart';
import 'package:logoipsum/Screen/view_image_screen.dart';
import 'package:logoipsum/Screen/select_styles_screen.dart';
// import 'dart:async';
import 'package:logoipsum/Screen/splash_screen.dart';
import 'package:logoipsum/Screen/selected_style_screen.dart';
import 'dart:io' show Platform;

void main() {
  runApp(const MyApp());
}

final isPlatformiOS = Platform.isIOS;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Splash Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF453560)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/spalsh': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/select_style': (context) => SelectStyleScreen(),
        '/styled_img_view': (context) => SelectedStyleScreen(),
        '/view_image_page': (context) => ViewImageScreen()
      },
    );
  }
}
