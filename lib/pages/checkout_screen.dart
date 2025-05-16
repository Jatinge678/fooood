import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;
  const CheckoutScreen({super.key, required this.selectedItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPayment = 'Google Pay';

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Order Confirmed'),
        content: const Text('Your food is being prepared and will arrive shortly.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text('OK', style: TextStyle(color: Colors.deepOrange)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.selectedItems.fold<int>(0, (sum, item) {
      return sum + (item['price'] as int) * (item['quantity'] as int);
    });
    const deliveryCharge = 30;
    const tax = 50;
    final total = subtotal + deliveryCharge + tax;

    final address = '123 Food Street, City Center, Mumbai, India';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepOrange),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Checkout', style: TextStyle(color: Colors.deepOrange)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Delivery Address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Iconsax.location, color: Colors.deepOrange),
                    title: const Text('Delivery Address'),
                    subtitle: Text(address),
                    trailing: const Icon(Icons.edit_location_alt, color: Colors.grey),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Navigate to address selection screen')));
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Order Summary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ...widget.selectedItems.map((item) => ListTile(
                        title: Text('${item['name']} x${item['quantity']}'),
                        trailing: Text('₹${(item['price'] as int?)! * (item['quantity'] as int?)!}'),
                      )),
                      const Divider(),
                      ListTile(
                        title: const Text('Subtotal'),
                        trailing: Text('₹$subtotal'),
                      ),
                      const ListTile(
                        title: Text('Delivery'),
                        trailing: Text('₹$deliveryCharge'),
                      ),
                      const ListTile(
                        title: Text('Tax'),
                        trailing: Text('₹$tax'),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: Text('₹$total', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Payment Method',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                StatefulBuilder(
                  builder: (context, setState) {
                    final paymentOptions = ['Google Pay', 'PayPal', 'Cash on Delivery', 'Paytm'];

                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const Icon(Icons.payment, color: Colors.deepOrange),
                        title: const Text('Select Payment Method'),
                        subtitle: DropdownButton<String>(
                          value: _selectedPayment,
                          isExpanded: true,
                          underline: Container(),
                          items: paymentOptions.map((method) {
                            return DropdownMenuItem<String>(
                              value: method,
                              child: Text(method),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedPayment = value);
                              this.setState(() => _selectedPayment = value);
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showConfirmationDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Confirm Order', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
