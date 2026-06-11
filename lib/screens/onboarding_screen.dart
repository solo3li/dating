import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to Dato",
      "description": "The ultimate voice dating and social app. Connect with people worldwide in real-time.",
      "image": "https://images.unsplash.com/photo-1517404215738-15263e9f9178?w=800&q=80",
    },
    {
      "title": "Voice Rooms",
      "description": "Join lively voice rooms, listen to music, play games, and make unforgettable memories.",
      "image": "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800&q=80",
    },
    {
      "title": "Live Streams",
      "description": "Watch your favorite broadcasters, send gifts, and witness epic moments.",
      "image": "https://images.unsplash.com/photo-1520092323719-21cb0fa49ce0?w=800&q=80",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return _buildPage(
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
                imageUrl: onboardingData[index]["image"]!,
              );
            },
          ),
          
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0, left: 32.0, right: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        onboardingData.length,
                        (index) => _buildDotIndicator(index),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_currentPage == onboardingData.length - 1) {
                          Navigator.pushReplacementNamed(context, '/login');
                        } else {
                          _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeOutCubic);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _currentPage == onboardingData.length - 1 ? 'Get Started' : 'Next',
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({required String title, required String description, required String imageUrl}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(imageUrl, fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, const Color(0xFF0D0D0D).withOpacity(0.95), const Color(0xFF0D0D0D)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.3, 0.7, 1.0],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1, letterSpacing: -1.0),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16, color: Color(0xFF8E8E93), height: 1.5),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDotIndicator(int index) {
    bool isSelected = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 6,
      width: isSelected ? 24 : 6,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
