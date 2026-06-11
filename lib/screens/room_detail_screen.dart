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
        title: Text(room?.title ?? 'Voice Room', style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz, color: Colors.white), onPressed: () {}),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(bgImage, fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(color: const Color(0xFF0F0F13).withOpacity(0.7)),
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
                        child: _PulsingAvatar(imageUrl: bgImage, size: 110, isSpeaking: true),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFFE040FB), Color(0xFF00E5FF)]),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(color: const Color(0xFFE040FB).withOpacity(0.4), blurRadius: 15)],
                        ),
                        child: Text(room?.hostName ?? 'Host', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
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
                            ? _PulsingAvatar(imageUrl: 'https://i.pravatar.cc/150?img=${index + 20}', size: 55, isSpeaking: index == 1)
                            : Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.05),
                                  border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                                ),
                                child: const Icon(Icons.add, color: Colors.white54, size: 20),
                              ),
                          const SizedBox(height: 8),
                          Text(hasUser ? 'User ${index+1}' : 'Empty', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.w600)),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: index % 2 == 0 ? [const Color(0xFFE040FB), const Color(0xFFFF4081)] : [const Color(0xFF00E5FF), const Color(0xFF00B0FF)]),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('Lv.${(index % 10) + 5}', style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 10),
                                Text('User $index:', style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.w800, fontSize: 14)),
                                const SizedBox(width: 8),
                                const Expanded(child: Text('Amazing room! 🔥', style: TextStyle(color: Colors.white, fontSize: 14))),
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
                      _buildControlButton(Icons.message_rounded, Colors.white.withOpacity(0.15)),
                      _buildControlButton(Icons.mic_off_rounded, Colors.white.withOpacity(0.15)),
                      _buildControlButton(Icons.videogame_asset_rounded, const Color(0xFF00E5FF)), 
                      _buildControlButton(Icons.card_giftcard_rounded, const Color(0xFFE040FB)), 
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: color.opacity > 0.5 ? [BoxShadow(color: color.withOpacity(0.6), blurRadius: 15, spreadRadius: 2)] : null,
      ),
      child: Icon(icon, color: Colors.white, size: 26),
    );
  }
}

class _PulsingAvatar extends StatefulWidget {
  final String imageUrl;
  final double size;
  final bool isSpeaking;

  const _PulsingAvatar({required this.imageUrl, required this.size, required this.isSpeaking});

  @override
  __PulsingAvatarState createState() => __PulsingAvatarState();
}

class __PulsingAvatarState extends State<_PulsingAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    if (widget.isSpeaking) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(_PulsingAvatar oldWidget) {
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
              width: widget.size + 10,
              height: widget.size + 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E5FF).withOpacity(0.3),
              ),
            ),
          ),
        Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: widget.isSpeaking ? const Color(0xFF00E5FF) : Colors.white24, width: 3),
            image: DecorationImage(image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
