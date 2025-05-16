// main.dart or settings.dart (full file)
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'edit_profile.dart';
import 'saved_addresses.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SettingTile(
            icon: Iconsax.profile_circle,
            title: 'Edit Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfilePage()),
              );
            },
          ),
          SettingTile(
            icon: Iconsax.location,
            title: 'Saved Addresses',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SavedAddressesPage()),
              );
            },
          ),
          SettingTile(
            icon: Iconsax.wallet_2,
            title: 'Payment Methods',
            onTap: () {},
          ),
          SettingTile(
            icon: Iconsax.clock,
            title: 'Order History',
            onTap: () {},
          ),
          SettingTile(
            icon: Iconsax.notification,
            title: 'Notifications',
            onTap: () {},
          ),
          SettingTile(
            icon: Iconsax.message_question,
            title: 'Help Center',
            onTap: () {},
          ),
          const Divider(height: 40),
          SettingTile(
            icon: Iconsax.logout,
            title: 'Logout',
            isLogout: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Logout logic here
                        Navigator.pop(context);
                      },
                      child: const Text('Logout', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrange.withOpacity(0.1),
          child: Icon(icon, color: Colors.deepOrange),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isLogout ? Colors.red : Colors.black,
          ),
        ),
        trailing: const Icon(Iconsax.arrow_right_34, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}