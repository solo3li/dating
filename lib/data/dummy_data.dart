class User {
  final String id;
  final String name;
  final String avatarUrl;
  final int level;
  final bool isVip;

  User({required this.id, required this.name, required this.avatarUrl, this.level = 1, this.isVip = false});
}

class VoiceRoom {
  final String id;
  final String title;
  final String hostName;
  final String hostAvatar;
  final String category;
  final int onlineCount;
  final String language;
  final List<String> tags;

  VoiceRoom({
    required this.id,
    required this.title,
    required this.hostName,
    required this.hostAvatar,
    required this.category,
    required this.onlineCount,
    required this.language,
    this.tags = const [],
  });
}

class LiveHost {
  final String id;
  final String name;
  final String avatarUrl;
  final int viewers;
  final int level;
  final bool isPkMode;

  LiveHost({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.viewers,
    required this.level,
    this.isPkMode = false,
  });
}

class Agency {
  final String id;
  final String name;
  final String logoUrl;
  final int rank;
  final int membersCount;
  final String monthlyRevenue;

  Agency({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.rank,
    required this.membersCount,
    required this.monthlyRevenue,
  });
}

class StoreItem {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  final String currency; // 'coins' or 'diamonds'
  final String type; // 'frame', 'car', 'vip'

  StoreItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.currency,
    required this.type,
  });
}

class DummyData {
  static final User currentUser = User(
    id: 'u1',
    name: 'Ahmed',
    avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=400&q=80',
    level: 45,
    isVip: true,
  );

  static final List<VoiceRoom> rooms = [
    VoiceRoom(id: 'r1', title: 'Let\'s Play Ludo 🎲', hostName: 'Sara', hostAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&q=80', category: 'Games', onlineCount: 145, language: 'AR', tags: ['Ludo', 'Fun', 'Active']),
    VoiceRoom(id: 'r2', title: 'Midnight Chill ☕', hostName: 'Omar', hostAvatar: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=400&q=80', category: 'Chat', onlineCount: 220, language: 'EN', tags: ['Chill', 'English', 'Night']),
    VoiceRoom(id: 'r3', title: 'Singing Night 🎤', hostName: 'Lina', hostAvatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400&q=80', category: 'Music', onlineCount: 350, language: 'AR', tags: ['Karaoke', 'Talent']),
    VoiceRoom(id: 'r4', title: 'Football Debate ⚽', hostName: 'Khaled', hostAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80', category: 'Sports', onlineCount: 80, language: 'AR', tags: ['Real Madrid', 'Barca']),
    VoiceRoom(id: 'r5', title: 'Looking for Friends ✨', hostName: 'Nour', hostAvatar: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=400&q=80', category: 'Dating', onlineCount: 500, language: 'AR', tags: ['Match', 'New Friends']),
    VoiceRoom(id: 'r6', title: 'Poetry & Art 🎨', hostName: 'Youssef', hostAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&q=80', category: 'Culture', onlineCount: 40, language: 'AR', tags: ['Poetry', 'Deep Talk']),
    VoiceRoom(id: 'r7', title: 'Tech Talk 💻', hostName: 'Mona', hostAvatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400&q=80', category: 'Tech', onlineCount: 120, language: 'EN', tags: ['Flutter', 'Coding']),
  ];

  static final List<LiveHost> hosts = [
    LiveHost(id: 'h1', name: 'Nour Han', avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400&q=80', viewers: 15400, level: 99, isPkMode: true),
    LiveHost(id: 'h2', name: 'DJ Youssef', avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400&q=80', viewers: 8200, level: 75),
    LiveHost(id: 'h3', name: 'Mona Star', avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&q=80', viewers: 23000, level: 88, isPkMode: true),
    LiveHost(id: 'h4', name: 'Ziad Gamer', avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&q=80', viewers: 4120, level: 42),
    LiveHost(id: 'h5', name: 'Leila Beauty', avatarUrl: 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=400&q=80', viewers: 9800, level: 60),
    LiveHost(id: 'h6', name: 'Tarek Vlogs', avatarUrl: 'https://images.unsplash.com/photo-1528892952291-009c663ce843?w=400&q=80', viewers: 3200, level: 25, isPkMode: true),
  ];

  static final List<Agency> agencies = [
    Agency(id: 'a1', name: 'Star Agency 🌟', logoUrl: 'https://images.unsplash.com/photo-1557683316-973673baf926?w=400&q=80', rank: 1, membersCount: 1250, monthlyRevenue: '50M+'),
    Agency(id: 'a2', name: 'Golden Talent 👑', logoUrl: 'https://images.unsplash.com/photo-1557682250-33bd709cbe85?w=400&q=80', rank: 2, membersCount: 820, monthlyRevenue: '32M+'),
    Agency(id: 'a3', name: 'Voice Kings 🎤', logoUrl: 'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=400&q=80', rank: 3, membersCount: 450, monthlyRevenue: '15M+'),
    Agency(id: 'a4', name: 'Elite Streamers', logoUrl: 'https://images.unsplash.com/photo-1557682224-5b8590cd9ec5?w=400&q=80', rank: 4, membersCount: 300, monthlyRevenue: '8M+'),
    Agency(id: 'a5', name: 'Rising Stars', logoUrl: 'https://images.unsplash.com/photo-1557682260-96773eb01377?w=400&q=80', rank: 5, membersCount: 150, monthlyRevenue: '4.5M+'),
  ];

  static final List<StoreItem> storeItems = [
    StoreItem(id: 's1', title: 'Fire Dragon Entry', imageUrl: 'https://images.unsplash.com/photo-1551269901-5c5e14c25df7?w=400&q=80', price: 15000, currency: 'coins', type: 'car'),
    StoreItem(id: 's2', title: 'Neon Frame', imageUrl: 'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?w=400&q=80', price: 1000, currency: 'coins', type: 'frame'),
    StoreItem(id: 's3', title: 'VIP Monthly', imageUrl: 'https://images.unsplash.com/photo-1620121692029-d088224ddc74?w=400&q=80', price: 300, currency: 'diamonds', type: 'vip'),
    StoreItem(id: 's4', title: 'Sports Car Entry', imageUrl: 'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=400&q=80', price: 8000, currency: 'coins', type: 'car'),
    StoreItem(id: 's5', title: 'Golden Frame', imageUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=400&q=80', price: 2500, currency: 'coins', type: 'frame'),
    StoreItem(id: 's6', title: 'Diamond VIP', imageUrl: 'https://images.unsplash.com/photo-1599839619722-39751411ea63?w=400&q=80', price: 1000, currency: 'diamonds', type: 'vip'),
  ];
}
