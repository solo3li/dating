import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';

class LiveTab extends StatelessWidget {
  const LiveTab({Key? key}) : super(key: key);

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
              title: const Text('Live Streamers', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF0F0F13), const Color(0xFF00E5FF).withOpacity(0.15)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFE040FB), Color(0xFF00E5FF)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: const Color(0xFFE040FB).withOpacity(0.5), blurRadius: 10)],
                ),
                child: IconButton(icon: const Icon(Icons.video_call, color: Colors.white), onPressed: () {}),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100, top: 8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final host = DummyData.hosts[index];
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 300 + (index * 150)),
                    curve: Curves.easeOutBack,
                    builder: (context, double value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
                          boxShadow: [
                            BoxShadow(color: const Color(0xFFE040FB).withOpacity(host.isPkMode ? 0.4 : 0), blurRadius: 20, spreadRadius: -2),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(host.avatarUrl, fit: BoxFit.cover),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.transparent, const Color(0xFF0F0F13).withOpacity(0.95)],
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              if (host.isPkMode)
                                Positioned(top: 12, left: 12, child: _PulsePKBadge()),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white24)),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.remove_red_eye, size: 12, color: Colors.white),
                                      const SizedBox(width: 4),
                                      Text('${host.viewers}', style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 16,
                                left: 12,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(host.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.white)),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [Color(0xFFE040FB), Color(0xFFFF4081)]),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text('Lv.${host.level}', style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: DummyData.hosts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsePKBadge extends StatefulWidget {
  @override
  __PulsePKBadgeState createState() => __PulsePKBadgeState();
}

class __PulsePKBadgeState extends State<_PulsePKBadge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.15).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.redAccent.withOpacity(0.6), blurRadius: 10)],
        ),
        child: const Row(
          children: [
            Icon(Icons.flash_on, color: Colors.yellowAccent, size: 14),
            SizedBox(width: 4),
            Text('PK', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }
}
