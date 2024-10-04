import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hni_project/view/pages/splash_screen.dart';
import 'package:hni_project/view_model/character_vm.dart';
import 'package:hni_project/view_model/spell_vm.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'view/pages/main_menu.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharacterViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SpellViewModel(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(),
          useMaterial3: true,
        ),
      ),
    );
  }
}
