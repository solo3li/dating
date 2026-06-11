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
        title: Text(room?.title ?? 'Voice Room', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz_rounded, color: Colors.white), onPressed: () {}),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(bgImage, fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(color: const Color(0xFF0D0D0D).withOpacity(0.85)),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Hero(
                        tag: 'avatar_${room?.id ?? ''}',
                        child: _SubtleAvatar(imageUrl: bgImage, size: 100, isSpeaking: true),
                      ),
                      const SizedBox(height: 16),
                      Text(room?.hostName ?? 'Host', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white)),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 24,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      bool hasUser = index < 3; 
                      return Column(
                        children: [
                          hasUser 
                            ? _SubtleAvatar(imageUrl: 'https://i.pravatar.cc/150?img=${index + 20}', size: 50, isSpeaking: index == 1)
                            : Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.05),
                                ),
                                child: const Icon(Icons.add_rounded, color: Colors.white54, size: 20),
                              ),
                          const SizedBox(height: 8),
                          Text(hasUser ? 'User ${index+1}' : 'Empty', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.6))),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text('Lv.${(index % 10) + 5}', style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w500)),
                                ),
                                const SizedBox(width: 8),
                                Text('User $index:', style: const TextStyle(color: Color(0xFF8E8E93), fontWeight: FontWeight.w500, fontSize: 13)),
                                const SizedBox(width: 6),
                                const Expanded(child: Text('Amazing room! 🙌', style: TextStyle(color: Color(0xFFEBEBF5), fontSize: 13))),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildControlButton(Icons.chat_bubble_outline_rounded, Colors.white.withOpacity(0.1)),
                      _buildControlButton(Icons.mic_off_rounded, Colors.white.withOpacity(0.1)),
                      _buildControlButton(Icons.sports_esports_rounded, Colors.white.withOpacity(0.1)), 
                      _buildControlButton(Icons.card_giftcard_rounded, const Color(0xFF30D158).withOpacity(0.2), iconColor: const Color(0xFF30D158)), 
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

  Widget _buildControlButton(IconData icon, Color bgColor, {Color iconColor = Colors.white}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: 24),
    );
  }
}

class _SubtleAvatar extends StatefulWidget {
  final String imageUrl;
  final double size;
  final bool isSpeaking;

  const _SubtleAvatar({required this.imageUrl, required this.size, required this.isSpeaking});

  @override
  __SubtleAvatarState createState() => __SubtleAvatarState();
}

class __SubtleAvatarState extends State<_SubtleAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    if (widget.isSpeaking) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(_SubtleAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSpeaking && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isSpeaking && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (widget.isSpeaking)
          ScaleTransition(
            scale: _animation,
            child: Container(
              width: widget.size + 8,
              height: widget.size + 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF30D158).withOpacity(0.5), width: 2),
              ),
            ),
          ),
        Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
