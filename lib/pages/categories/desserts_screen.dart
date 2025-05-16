import 'package:flutter/material.dart';
import 'package:flutterdelivery1/models/cart.dart';

class DessertsScreen extends StatelessWidget {
  const DessertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> desserts = [
      {'name': 'Chocolate Cake', 'price': 120, 'icon': Icons.cake},
      {'name': 'Ice Cream Sundae', 'price': 90, 'icon': Icons.icecream},
      {'name': 'Strawberry Tart', 'price': 110, 'icon': Icons.local_cafe},
      {'name': 'Donut Delight', 'price': 80, 'icon': Icons.donut_small},
      {'name': 'Brownie Blast', 'price': 100, 'icon': Icons.cookie},
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFF3E0), Color(0xFFFFEBEE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Desserts'),
          backgroundColor: Colors.pinkAccent.withOpacity(0.9),
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: desserts.map((item) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Hero(
                  tag: item['name'],
                  child: Icon(item['icon'], color: Colors.pinkAccent, size: 32),
                ),
                title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('₹${item['price']} - Sweet and delicious treat'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Scaffold(
                        appBar: AppBar(title: Text(item['name'])),
                        body: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Hero(tag: item['name'], child: Icon(item['icon'], size: 80, color: Colors.pinkAccent)),
                                    const SizedBox(height: 20),
                                    Text(item['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                    Text('Price: ₹${item['price']}', style: const TextStyle(fontSize: 20)),
                                    const SizedBox(height: 16),
                                    const Text('Ingredients: Coming soon...', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                                    const SizedBox(height: 8),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.star, color: Colors.amber),
                                        SizedBox(width: 4),
                                        Text('4.7', style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        cartItems.add({
                                          'name': item['name'],
                                          'price': item['price'],
                                          'image': item['icon'],
                                          'quantity': 1,
                                          'selected': false,
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('${item['name']} added to cart!')),
                                        );
                                      },
                                      icon: const Icon(Icons.add_shopping_cart),
                                      label: const Text('Add to Cart', style: TextStyle(color: Colors.white),),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pinkAccent,
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
      ),
    );
  }
}