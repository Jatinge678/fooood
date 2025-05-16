

import 'package:flutter/material.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> offers = [
      {
        'title': '20% Off First Order',
        'description': 'Get 20% off on your first order. No code needed!',
        'discount': '20%',
        'icon': Icons.local_offer,
      },
      {
        'title': 'Free Dessert',
        'description': 'Free dessert on orders above ₹499.',
        'discount': 'Free Dessert',
        'icon': Icons.cake,
      },
      {
        'title': 'Buy 1 Get 1',
        'description': 'Applicable on selected cafes only.',
        'discount': 'BOGO',
        'icon': Icons.coffee,
      },
      {
        'title': 'Weekend Feast',
        'description': 'Flat ₹150 off this weekend. Use code: FEAST150.',
        'discount': '₹150 Off',
        'icon': Icons.weekend,
      },
      {
        'title': 'Midnight Munchies',
        'description': '10% off on all orders after 11 PM.',
        'discount': '10% Off',
        'icon': Icons.nightlife,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Offers')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: offers.map((offer) {
          return Card(
            color: Colors.orange[50],
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Hero(
                tag: offer['title'],
                child: Icon(offer['icon'], color: Colors.deepOrange, size: 32),
              ),
              title: Text(offer['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(offer['description']),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: Text(offer['title'])),
                      body: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Hero(tag: offer['title'], child: Icon(offer['icon'], size: 80, color: Colors.deepOrange)),
                                  const SizedBox(height: 20),
                                  Text(offer['title'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  Text(offer['description'], style: const TextStyle(fontSize: 16)),
                                  const SizedBox(height: 16),
                                  Text('You save: ${offer['discount']}', style: const TextStyle(fontSize: 18, color: Colors.green)),
                                  const SizedBox(height: 24),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Offer applied successfully!')),
                                      );
                                    },
                                    icon: const Icon(Icons.check_circle_outline),
                                    label: const Text('Apply Offer'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepOrange,
                                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}