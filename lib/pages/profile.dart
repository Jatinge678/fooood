import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
// ignore: unused_import
import 'settings/saved_addresses.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepOrange.shade100,
                    Colors.deepOrange.shade50,
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Iconsax.profile_circle,
                        size: 60,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'john.doe@example.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Profile Options
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Personal Info
                  _buildProfileOption(
                    icon: Iconsax.profile_circle,
                    title: 'Personal Information',
                    onTap: () {},
                  ),
                  // Addresses
                  _buildProfileOption(
                    icon: Iconsax.location,
                    title: 'Saved Addresses',
                    onTap: () {},
                  ),
                  // Payment Methods
                  _buildProfileOption(
                    icon: Iconsax.wallet,
                    title: 'Payment Methods',
                    onTap: () {},
                  ),
                  // Order History
                  _buildProfileOption(
                    icon: Iconsax.receipt,
                    title: 'Order History',
                    onTap: () {},
                  ),
                  // Favorites
                  _buildProfileOption(
                    icon: Iconsax.heart,
                    title: 'Favorites',
                    onTap: () {},
                  ),
                  // Notifications
                  _buildProfileOption(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  // Help Center
                  _buildProfileOption(
                    icon: Iconsax.message_question,
                    title: 'Help Center',
                    onTap: () {},
                  ),
                  // Settings
                  _buildProfileOption(
                    icon: Iconsax.setting,
                    title: 'Settings',
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Log Out'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.deepOrange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.deepOrange),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }
}