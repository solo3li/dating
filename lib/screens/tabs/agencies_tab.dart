import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';

class AgenciesTab extends StatelessWidget {
  const AgenciesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Agencies'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: DummyData.agencies.length,
        itemBuilder: (context, index) {
          final agency = DummyData.agencies[index];
          return Card(
            color: const Color(0xFF2C2C2C),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(agency.logoUrl), radius: 25),
                  if (agency.rank <= 3)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: agency.rank == 1 ? Colors.amber : (agency.rank == 2 ? Colors.grey[300] : Colors.orange),
                        child: Text('${agency.rank}', style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
              title: Text(agency.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${agency.membersCount} Members • ${agency.monthlyRevenue} Rev'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () {},
                child: const Text('Join'),
              ),
            ),
          );
        },
      ),
    );
  }
}
