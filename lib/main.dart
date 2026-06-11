import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/room_detail_screen.dart';

void main() {
  runApp(const DatoApp());
}

class DatoApp extends StatelessWidget {
  const DatoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dato',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE040FB), // Neon Pink
        scaffoldBackgroundColor: const Color(0xFF0F0F13), // Deep Dark
        textTheme: GoogleFonts.outfitTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: Color(0xFFE040FB),
          unselectedItemColor: Colors.grey,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE040FB),
          secondary: Color(0xFF00E5FF),
        ),
      ),
      builder: (context, child) {
        // Mobile Simulator Frame for Web
        return Scaffold(
          backgroundColor: Colors.black87,
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              decoration: BoxDecoration(
                color: const Color(0xFF0F0F13),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(color: const Color(0xFFE040FB).withOpacity(0.15), blurRadius: 40, spreadRadius: 10),
                  BoxShadow(color: const Color(0xFF00E5FF).withOpacity(0.1), blurRadius: 60, spreadRadius: -5),
                ],
                border: Border.all(color: Colors.white.withOpacity(0.1), width: 8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: child!,
              ),
            ),
          ),
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/room': (context) => const RoomDetailScreen(),
      },
    );
  }
}
