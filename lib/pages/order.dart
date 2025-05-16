import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:iconsax/iconsax.dart';

class OrderPage extends StatefulWidget {
  final String name;
  final int price;
  final IconData icon;

  const OrderPage({super.key, required this.name, required this.price, required this.icon});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late List<Map<String, dynamic>> _activeOrders;

  @override
  void initState() {
    super.initState();
    _activeOrders = [
      {
        'id': '#FD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
        'restaurant': widget.name,
        'status': 'Preparing',
        'items': 1,
        'total': widget.price.toDouble(),
        'time': '25-30 min',
        'image': null,
        'icon': widget.icon,
      },
    ];
  }

  final List<Map<String, dynamic>> _pastOrders = [
    {
      'id': '#FD-784510',
      'restaurant': 'McDonald\'s',
      'date': 'Today, 12:30 PM',
      'items': 4,
      'total': 32.75,
      'image': null,
      'icon': Icons.fastfood,
    },
    {
      'id': '#FD-784509',
      'restaurant': 'KFC',
      'date': 'Yesterday, 7:45 PM',
      'items': 2,
      'total': 22.40,
      'image': null,
      'icon': Icons.lunch_dining,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('My Orders'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.deepOrange,
            labelColor: Colors.deepOrange,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Active Orders Tab
            _activeOrders.isEmpty
                ? const Center(
                    child: Text(
                      'No active orders',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _activeOrders.length,
                    itemBuilder: (context, index) {
                      final order = _activeOrders[index];
                      return _buildOrderCard(
                        context,
                        order: order,
                        isActive: true,
                      );
                    },
                  ),

            // Past Orders Tab
            _pastOrders.isEmpty
                ? const Center(
                    child: Text(
                      'No past orders',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _pastOrders.length,
                    itemBuilder: (context, index) {
                      final order = _pastOrders[index];
                      return _buildOrderCard(
                        context,
                        order: order,
                        isActive: false,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required Map<String, dynamic> order,
    required bool isActive,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Restaurant Image or Icon
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: order['image'] != null
                      ? Image.asset(
                          order['image'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.orange.shade50,
                          child: Icon(order['icon'], color: Colors.deepOrange),
                        ),
                ),
                const SizedBox(width: 12),
                // Order Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['restaurant'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order['id'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${order['items']} item${order['items'] > 1 ? 's' : ''} • \$${order['total'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Status/Date and Action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isActive ? 'Status' : 'Delivered on',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isActive ? order['status'] : order['date'],
                      style: TextStyle(
                        fontSize: 14,
                        color: isActive ? Colors.deepOrange : Colors.grey[800],
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isActive) ...[
                      const SizedBox(height: 4),
                      Text(
                        order['time'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // View order details
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepOrange,
                    side: const BorderSide(color: Colors.deepOrange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: Text(isActive ? 'Track' : 'Reorder'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}