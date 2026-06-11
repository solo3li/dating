import 'dart:ui';
import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';

class VoiceRoomsTab extends StatelessWidget {
  const VoiceRoomsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF0D0D0D).withOpacity(0.9),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text('Discover', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28, letterSpacing: -0.5, color: Colors.white)),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.search_rounded, color: Colors.white, size: 28), onPressed: () {}),
              IconButton(icon: const Icon(Icons.add_circle_rounded, color: Colors.white, size: 28), onPressed: () {}),
              const SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 100.0, top: 8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final room = DummyData.rooms[index];
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    curve: Curves.easeOutCubic,
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/room', arguments: room),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withOpacity(0.05)),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Hero(
                                tag: 'avatar_${room.id}',
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: NetworkImage(room.hostAvatar), fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(room.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white)),
                                    const SizedBox(height: 4),
                                    Text(room.hostName, style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 14)),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: room.tags.map((tag) => Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF2C2C2E),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(tag, style: const TextStyle(color: Color(0xFFEBEBF5), fontSize: 11, fontWeight: FontWeight.w500)),
                                      )).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF30D158).withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.graphic_eq_rounded, color: Color(0xFF30D158), size: 18),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.person_rounded, color: Color(0xFF8E8E93), size: 14),
                                      const SizedBox(width: 4),
                                      Text('${room.onlineCount}', style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 12, fontWeight: FontWeight.w600)),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: DummyData.rooms.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
