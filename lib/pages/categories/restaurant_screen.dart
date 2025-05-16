import 'package:flutterdelivery1/models/cart.dart';
import 'package:flutter/material.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> restaurants = [
      {
        'name': 'Spice Delight',
        'description': 'Authentic Indian Cuisine',
        'image': Icons.restaurant,
        'menu': [
          {'name': 'Butter Chicken', 'price': 250, 'icon': Icons.rice_bowl},
          {'name': 'Paneer Tikka', 'price': 200, 'icon': Icons.local_fire_department},
          {'name': 'Garlic Naan', 'price': 50, 'icon': Icons.bakery_dining}
        ]
      },
      {
        'name': 'Burger House',
        'description': 'Best grilled burgers in town',
        'image': Icons.fastfood,
        'menu': [
          {'name': 'Cheese Burger', 'price': 150, 'icon': Icons.fastfood},
          {'name': 'Veggie Burger', 'price': 130, 'icon': Icons.grass},
          {'name': 'Fries', 'price': 70, 'icon': Icons.local_pizza}
        ]
      },
      {
        'name': 'Sushi Hub',
        'description': 'Fresh sushi and sashimi',
        'image': Icons.ramen_dining,
        'menu': [
          {'name': 'California Roll', 'price': 300, 'icon': Icons.set_meal},
          {'name': 'Tuna Sashimi', 'price': 350, 'icon': Icons.lunch_dining},
          {'name': 'Miso Soup', 'price': 100, 'icon': Icons.soup_kitchen}
        ]
      }
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
          title: const Text('Restaurants'),
          backgroundColor: Colors.deepOrange.withOpacity(0.9),
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (var restaurant in restaurants) ...[
              Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Icon(restaurant['image'], color: Colors.deepOrange),
                    title: Text(restaurant['name']),
                    subtitle: Text(restaurant['description']),
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        child: Column(
                          children: List.generate(
                            restaurant['menu'].length,
                            (index) {
                              final item = restaurant['menu'][index];
                              return ListTile(
                                title: Text(item['name']),
                                subtitle: Text('₹${item['price']}'),
                                leading: Hero(
                                  tag: item['name'],
                                  child: Icon(item['icon'], color: Colors.orange),
                                ),
                                trailing: const Icon(Icons.add_circle_outline, color: Colors.deepOrange),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Scaffold(
                                        appBar: AppBar(
                                          title: Text(item['name']),
                                          backgroundColor: Colors.deepOrange.withOpacity(0.9),
                                          elevation: 0,
                                        ),
                                        body: SingleChildScrollView(
                                          child: Padding(
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
                                                      Hero(
                                                        tag: item['name'],
                                                        child: Icon(item['icon'], size: 80, color: Colors.deepOrange),
                                                      ),
                                                      const SizedBox(height: 20),
                                                      Text(
                                                        item['name'],
                                                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        'Price: ₹${item['price']}',
                                                        style: const TextStyle(fontSize: 20),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      const Text(
                                                        'Ingredients: Coming soon...',
                                                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      const Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(Icons.star, color: Colors.amber),
                                                          SizedBox(width: 4),
                                                          Text('4.5', style: TextStyle(fontSize: 16)),
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
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.deepOrangeAccent, thickness: 1, height: 20),
            ],
          ],
        ),
      ),
    );
  }
}