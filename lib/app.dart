import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tutorial_flow.dart';

class PlantApp extends StatelessWidget {
  const PlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFFC57AE6);
    const text = Color(0xFF2C2241);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Identificator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          primary: const Color(0xFFC57AE6),
          secondary: const Color(0xFF7A42B2),
          surface: const Color(0xFFFAF7FD),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF7FD),
        textTheme: TextTheme(
          displaySmall: GoogleFonts.manrope(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: text,
          ),
          headlineSmall: GoogleFonts.manrope(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: text,
          ),
          titleLarge: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: text,
          ),
          bodyLarge: GoogleFonts.manrope(
            fontSize: 16,
            height: 1.4,
            color: const Color(0xFF3B2F4E),
          ),
          bodyMedium: GoogleFonts.manrope(
            fontSize: 14,
            height: 1.4,
            color: const Color(0xFF3B2F4E),
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Color(0x26C57AE6),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFC57AE6),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC57AE6),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xFFC57AE6), width: 1.4),
          ),
        ),
      ),
      home: const TutorialFlow(),
    );
  }
}



