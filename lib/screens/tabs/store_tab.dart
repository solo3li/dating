import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';

class StoreTab extends StatelessWidget {
  const StoreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Store'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Cars'),
              Tab(text: 'Frames'),
              Tab(text: 'VIP'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildStoreGrid('car'),
            _buildStoreGrid('frame'),
            _buildStoreGrid('vip'),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreGrid(String type) {
    final items = DummyData.storeItems.where((item) => item.type == type).toList();
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          color: const Color(0xFF2C2C2C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(item.imageUrl, fit: BoxFit.contain),
                ),
              ),
              Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.currency == 'coins' ? Icons.monetization_on : Icons.diamond, 
                       color: item.currency == 'coins' ? Colors.amber : Colors.blue, size: 16),
                  const SizedBox(width: 4),
                  Text('${item.price}'),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () {},
                child: const Text('Purchase'),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
