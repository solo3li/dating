import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
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
        primaryColor: const Color(0xFFF2F2F7), // Apple-like off-white
        scaffoldBackgroundColor: const Color(0xFF0D0D0D), // True matte dark
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: const Color(0xFFEBEBF5), displayColor: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xFF636366),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Color(0xFF30D158), // Apple green accent
          surface: Color(0xFF1C1C1E),
        ),
      ),
      builder: (context, child) {
        // Clean Mobile Simulator Frame
        return Scaffold(
          backgroundColor: const Color(0xFF1C1C1E), // Subtle dark grey background for web
          body: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: const Color(0xFF0D0D0D),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, spreadRadius: 0, offset: const Offset(0, 10)),
                ],
                border: Border.all(color: const Color(0xFF2C2C2E), width: 6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(34),
                child: child!,
              ),
            ),
          ),
        );
      },
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/room': (context) => const RoomDetailScreen(),
      },
    );
  }
}
