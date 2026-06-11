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
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
            boxShadow: [
              BoxShadow(color: const Color(0xFFE040FB).withOpacity(0.15), blurRadius: 20, spreadRadius: 2, offset: const Offset(0, 10)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Container(
                height: 70,
                color: Colors.black.withOpacity(0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: isSelected ? const LinearGradient(colors: [Color(0xFFE040FB), Color(0xFF00E5FF)]) : null,
          shape: BoxShape.circle,
          boxShadow: isSelected ? [BoxShadow(color: const Color(0xFFE040FB).withOpacity(0.5), blurRadius: 10)] : null,
        ),
        child: Icon(icon, color: isSelected ? Colors.white : Colors.white54, size: isSelected ? 28 : 24),
      ),
    );
  }
}
