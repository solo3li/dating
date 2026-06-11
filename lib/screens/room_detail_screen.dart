import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final room = ModalRoute.of(context)!.settings.arguments as VoiceRoom?;
    final bgImage = room?.hostAvatar ?? DummyData.currentUser.avatarUrl;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(room?.title ?? 'Voice Room', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred Background
          Image.network(bgImage, fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Host Seat
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Hero(
                        tag: 'avatar_${room?.id ?? ''}',
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE040FB), width: 3),
                            image: DecorationImage(image: NetworkImage(bgImage), fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(color: const Color(0xFFE040FB).withOpacity(0.5), blurRadius: 20, spreadRadius: 2),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(room?.hostName ?? 'Host', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                
                // Audience Seats Grid
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(24),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 24,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      bool hasUser = index < 3; // Mocking first 3 seats taken
                      return Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasUser ? null : Colors.white.withOpacity(0.1),
                              image: hasUser ? DecorationImage(image: NetworkImage('https://i.pravatar.cc/150?img=${index + 20}')) : null,
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: hasUser ? null : const Icon(Icons.add, color: Colors.white54),
                          ),
                          const SizedBox(height: 8),
                          Text(hasUser ? 'User ${index+1}' : 'Empty', style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.8))),
                        ],
                      );
                    },
                  ),
                ),

                // Glassmorphism Live Chat Area
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0 ? Colors.blue : Colors.pink,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text('Lv.${(index % 10) + 5}', style: const TextStyle(fontSize: 10, color: Colors.white)),
                                ),
                                const SizedBox(width: 8),
                                Text('User $index:', style: TextStyle(color: Colors.yellow[300], fontWeight: FontWeight.bold, fontSize: 13)),
                                const SizedBox(width: 6),
                                const Expanded(child: Text('Amazing room! 🔥', style: TextStyle(color: Colors.white, fontSize: 13))),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // Bottom Controls
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildControlButton(Icons.message, Colors.white.withOpacity(0.2)),
                      _buildControlButton(Icons.mic_off, Colors.white.withOpacity(0.2)),
                      _buildControlButton(Icons.videogame_asset, const Color(0xFF00E5FF)), // Electric Blue for Games
                      _buildControlButton(Icons.card_giftcard, const Color(0xFFE040FB)), // Pink for Gifts
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: color.opacity > 0.5 ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 10, spreadRadius: 1)] : null,
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}
