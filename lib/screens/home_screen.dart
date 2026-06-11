import 'dart:ui';
import 'package:flutter/material.dart';
import 'tabs/voice_rooms_tab.dart';
import 'tabs/live_tab.dart';
import 'tabs/agencies_tab.dart';
import 'tabs/store_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const VoiceRoomsTab(),
    const LiveTab(),
    const AgenciesTab(),
    const StoreTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows body to flow under the floating nav bar
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.white.withOpacity(0.05),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedIconTheme: const IconThemeData(size: 28),
                unselectedIconTheme: const IconThemeData(size: 24),
                items: [
                  _buildNavItem(Icons.headset_mic, 0),
                  _buildNavItem(Icons.live_tv, 1),
                  _buildNavItem(Icons.business, 2),
                  _buildNavItem(Icons.store, 3),
                  _buildNavItem(Icons.person, 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: _currentIndex == index
              ? const LinearGradient(colors: [Color(0xFFE040FB), Color(0xFF00E5FF)])
              : null,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: _currentIndex == index ? Colors.white : Colors.grey),
      ),
      label: '',
    );
  }
}
