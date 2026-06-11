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
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: const Text('Discover Rooms', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF0F0F13), const Color(0xFFE040FB).withOpacity(0.2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Color(0xFF00E5FF), blurRadius: 10, spreadRadius: -2)],
                ),
                child: IconButton(icon: const Icon(Icons.add_box, color: Color(0xFF00E5FF)), onPressed: () {}),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 100.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final room = DummyData.rooms[index];
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 400 + (index * 100)),
                    curve: Curves.easeOutCubic,
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/room', arguments: room),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E24),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white.withOpacity(0.05)),
                          boxShadow: [
                            BoxShadow(color: const Color(0xFFE040FB).withOpacity(0.08), blurRadius: 20, spreadRadius: 1),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Hero(
                                tag: 'avatar_${room.id}',
                                child: Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFE040FB), width: 2.5),
                                    image: DecorationImage(image: NetworkImage(room.hostAvatar), fit: BoxFit.cover),
                                    boxShadow: [BoxShadow(color: const Color(0xFFE040FB).withOpacity(0.4), blurRadius: 10)],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(room.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                    const SizedBox(height: 4),
                                    Text(room.hostName, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: room.tags.map((tag) => Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE040FB).withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: const Color(0xFFE040FB).withOpacity(0.3)),
                                        ),
                                        child: Text(tag, style: const TextStyle(color: Color(0xFFE040FB), fontSize: 11, fontWeight: FontWeight.w600)),
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
                                      gradient: const LinearGradient(colors: [Color(0xFF00E5FF), Color(0xFF00B0FF)]),
                                      shape: BoxShape.circle,
                                      boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withOpacity(0.5), blurRadius: 8)],
                                    ),
                                    child: const Icon(Icons.graphic_eq, color: Colors.black, size: 18),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Icon(Icons.people_alt, color: Colors.grey, size: 14),
                                      const SizedBox(width: 4),
                                      Text('${room.onlineCount}', style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold)),
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
