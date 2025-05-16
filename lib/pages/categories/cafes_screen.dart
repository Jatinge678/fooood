import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterdelivery1/models/cart.dart';
import 'package:flutter/material.dart';

class CafeScreen extends StatefulWidget {
  const CafeScreen({super.key});

  @override
  State<CafeScreen> createState() => _CafeScreenState();
}

class _CafeScreenState extends State<CafeScreen> {
  List<Map<String, dynamic>> _cafes = [];

  @override
  void initState() {
    super.initState();
    fetchCafes();
  }

  Future<void> fetchCafes() async {
    final url = Uri.parse('http://127.0.0.1:5000/cafes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _cafes = data.map((e) => {
          'name': e['name'],
          'price': e['price'],
          'icon': Icons.local_cafe, // default icon; you can parse if passed from backend
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFD7CCC8), Color(0xFFFFF8E1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Café'),
          backgroundColor: Colors.brown.withOpacity(0.9),
          elevation: 0,
        ),
        body: _cafes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cafes.length,
              itemBuilder: (context, index) {
                final item = _cafes[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Hero(
                      tag: item['name'],
                      child: Icon(item['icon'], color: Colors.brown, size: 32),
                    ),
                    title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('₹${item['price']} - Cozy coffee spot'),
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
                                        Hero(tag: item['name'], child: Icon(item['icon'], size: 80, color: Colors.brown)),
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
                                            Text('4.6', style: TextStyle(fontSize: 16)),
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
                                          label: const Text('Add to Cart'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.brown,
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
              },
            ),
      ),
    );
  }
}