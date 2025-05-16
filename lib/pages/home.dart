import 'package:flutter/material.dart';
import 'package:flutterdelivery1/pages/categories/cafes_screen.dart';
import 'package:flutterdelivery1/pages/categories/restaurant_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutterdelivery1/widget/food_category.dart';
import 'package:flutterdelivery1/widget/restaurant_card.dart';
import 'package:flutterdelivery1/models/cart.dart';
import 'package:flutterdelivery1/widget/food_item_card.dart';
import 'package:flutterdelivery1/pages/profile.dart';
import 'package:flutterdelivery1/pages/settings/settings.dart';
import 'package:flutterdelivery1/pages/wallet.dart';
import 'shopping_cart.dart';
import 'notification_screen.dart';
import 'package:flutterdelivery1/pages/categories/desserts_screen.dart';
import 'package:flutterdelivery1/pages/order.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const Wallet(),
    const Profile(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.wallet),
                label: 'Wallet',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_circle),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.setting),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'Restaurants';
  final List<Map<String, dynamic>> _categories = [
    {'label': 'Restaurants', 'icon': Iconsax.shop},
    {'label': 'Desserts', 'icon': Iconsax.cake},
    {'label': 'Café', 'icon': Iconsax.coffee},
  ];

  // For location editing
  bool _isEditingLocation = false;
  late TextEditingController _locationController;
  String _currentLocation = 'Current Location';
  final List<String> _locationSuggestions = [
    'Home',
    'Work',
    'My Hostel',
    'Other Location'
  ];

  // Example static data for demo; you can replace with dynamic data
  final List<Map<String, dynamic>> restaurantList = [
    {
      'name': 'Burger King',
      'rating': 4.5,
      'deliveryTime': '20-30 min',
      'imageUrl': 'assets/images/burger.png',
      'price': 199,
      'icon': Icons.fastfood,
    },
    {
      'name': 'Pizza Hut',
      'rating': 4.2,
      'deliveryTime': '25-35 min',
      'imageUrl': 'assets/images/pizza.png',
      'price': 249,
      'icon': Icons.local_pizza,
    },
    {
      'name': 'Healthy Salad',
      'rating': 4.7,
      'deliveryTime': '30-40 min',
      'imageUrl': 'assets/images/salad2.png',
      'price': 149,
      'icon': Icons.emoji_nature,
    },
  ];

  final List<Map<String, dynamic>> foodList = [
    {
      'name': 'Cheese Burger',
      'price': 50,
      'rating': 4.5,
      'imageUrl': 'assets/images/burger.png',
      'icon': Icons.fastfood,
    },
    {
      'name': 'Veg Pizza',
      'price': 149,
      'rating': 4.2,
      'imageUrl': 'assets/images/pizza.png',
      'icon': Icons.local_pizza,
    },
    {
      'name': 'Healthy Salad',
      'price': 349,
      'rating': 4.3,
      'imageUrl': 'assets/images/salad2.png',
      'icon': Icons.emoji_nature,
    },
    {
      'name': 'Fresh Salad',
      'price': 120,
      'rating': 4.1,
      'imageUrl': 'assets/images/salad3.png',
      'icon': Icons.eco,
    },
  ];

  int cartItemCount = 3; // Example cart item count for badge

  Future<void> _onRefresh() async {
    // Simulate a refresh
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController(text: _currentLocation);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {});
  }

  void _voiceInput() {
    // TODO: Implement voice input functionality
    print('Voice input tapped');
  }

  // Widget for expandable location selector in the AppBar
  Widget _buildExpandableLocationSelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: !_isEditingLocation
          // Display mode
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery to',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEditingLocation = true;
                      _locationController.text = _currentLocation;
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.deepOrange, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        _currentLocation,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey),
                    ],
                  ),
                ),
              ],
            )
          // Editing mode
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set delivery location',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.deepOrange, size: 20),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: _locationController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Enter location...',
                          isDense: true,
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.check, color: Colors.deepOrange),
                            onPressed: () {
                              setState(() {
                                _currentLocation = _locationController.text.trim().isEmpty
                                    ? _currentLocation
                                    : _locationController.text.trim();
                                _isEditingLocation = false;
                              });
                            },
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            if (value.trim().isNotEmpty) {
                              _currentLocation = value.trim();
                            }
                            _isEditingLocation = false;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _isEditingLocation = false;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Suggestion chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _locationSuggestions.map((loc) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(loc),
                          selected: _locationController.text == loc,
                          selectedColor: Colors.deepOrange.withOpacity(0.15),
                          onSelected: (_) {
                            setState(() {
                              _locationController.text = loc;
                              _currentLocation = loc;
                              _isEditingLocation = false;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.fastfood, color: Colors.deepOrange),
            SizedBox(width: 6),
            Text(
              'Fooliever',
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification, color: Colors.deepOrange),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Iconsax.shopping_cart, color: Colors.deepOrange),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShoppingCartPage()),
                  );
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location Selector
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: _buildExpandableLocationSelector(),
                  ),
                  // Search Bar (Responsive)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search for restaurants or dishes...',
                              prefixIcon: const Icon(Iconsax.search_normal, color: Colors.deepOrange),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_searchController.text.isNotEmpty)
                                    IconButton(
                                      icon: const Icon(Icons.clear, color: Colors.deepOrange),
                                      onPressed: _clearSearch,
                                    ),
                                  IconButton(
                                    icon: const Icon(Icons.mic, color: Colors.deepOrange),
                                    onPressed: _voiceInput,
                                  ),
                                ],
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                            onSubmitted: (value) {
                              print('Search submitted: $value');
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  // Food Categories
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: GestureDetector(
                            onTap: () {
                              Widget screen;
                              switch (category['label']) {
                                case 'Restaurants':
                                  screen = const RestaurantsScreen();
                                  break;
                                case 'Desserts':
                                  screen = const DessertsScreen();
                                  break;
                                case 'Café':
                                  screen = const CafeScreen();
                                  break;
                                default:
                                  screen = const Scaffold(body: Center(child: Text('Unknown category')));
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => screen),
                              );
                            },
                            child: FoodCategory(
                              icon: category['icon'],
                              label: category['label'],
                              isActive: _selectedCategory == category['label'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Divider & Spacing after categories
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(),
                  ),
                  const SizedBox(height: 8),

                  // Popular Near You
                  _buildSectionHeader(
                    title: 'Popular Near You',
                    onViewAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            // TODO: Replace with actual popular restaurants page
                            return Scaffold(
                              appBar: AppBar(title: const Text('Popular Restaurants')),
                              body: const Center(child: Text('Popular Restaurants List')),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  SizedBox(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: restaurantList.length,
                      itemBuilder: (context, idx) {
                        final rest = restaurantList[idx];
                        // TODO: Add shimmer effect or loading indicator here if data is loading
                        return Row(
                          children: [
                            RestaurantCard(
                              name: rest['name'],
                              rating: rest['rating'],
                              deliveryTime: rest['deliveryTime'],
                              imageUrl: rest['imageUrl'],
                              showFavorite: true,
                              showStar: true,
                              onOrderNow: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OrderPage(
                                      name: rest['name'],
                                      price: rest['price'],
                                      icon: rest['icon'],
                                    ),
                                  ),
                                );
                              },
                            ),
                            if (idx != restaurantList.length - 1) const SizedBox(width: 16),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Special Offers Banner
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/buy1get1free.png',
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // What Would You Like Today
                  _buildSectionHeader(
                    title: 'What would you like today?',
                    onViewAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            // TODO: Replace with actual food items page
                            return Scaffold(
                              appBar: AppBar(title: const Text('Food Items')),
                              body: const Center(child: Text('Food Items List')),
                            );
                          },
                        ),
                      );
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: foodList.length,
                      itemBuilder: (context, idx) {
                        final food = foodList[idx];
                        // TODO: Add shimmer effect or loading indicator here if data is loading
                        return FoodItemCard(
                          name: food['name'],
                          price: food['price'],
                          rating: food['rating'],
                          imageUrl: food['imageUrl'],
                          showFavorite: true,
                          showStar: true,
                          onOrderNow: () {
                            cartItems.add({
                              'name': food['name'],
                              'price': food['price'],
                              'image': food['icon'],
                              'quantity': 1,
                              'selected': false,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${food['name']} added to cart!')),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required VoidCallback onViewAll}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            child: const Text(
              'View All',
              style: TextStyle(color: Colors.deepOrange),
            ),
          ),
        ],
      ),
    );
  }
}
