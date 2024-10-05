import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hni_project/view/pages/main_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      () {
        Get.off(()=> const MainMenu());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash_atas.png"),
            SizedBox(
              width: 260,
              height: 113,
              child: Image.asset("assets/images/logo.png"),
            ),
            Image.asset("assets/images/splash_bawah.png"),
          ],
        ),
      ),
    );
  }
}
