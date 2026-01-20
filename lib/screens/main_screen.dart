import 'package:ecommerce_app/screens/fake_dummy_data.dart';
import 'package:flutter/material.dart';
import 'product_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedCategory = "Trending";

  @override
  Widget build(BuildContext context) {
    // 1. FILTER: Find products that match the selected category
    List<Product> displayedProducts = allProducts
        .where((p) => p.category == selectedCategory)
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // --- TOP SECTION (App Bar & Search) ---
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFE5E5E0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu, color: Colors.black, size: 28),
                    const Text(
                      'Lumière',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Stack(
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.black,
                          size: 28,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 12,
                            width: 12,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search your needs",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- MAIN CONTENT SECTION ---
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25),

                  // Category Tabs
                  _buildCategoryList(),

                  const SizedBox(height: 20),

                  // The Dynamic Staggered Grid
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column
                          Expanded(
                            child: Column(
                              children: [
                                if (displayedProducts.isNotEmpty)
                                  _buildManualCard(
                                    context,
                                    displayedProducts[0],
                                  ),
                                const SizedBox(height: 20),
                                if (displayedProducts.length > 2)
                                  _buildManualCard(
                                    context,
                                    displayedProducts[2],
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          // Right Column
                          Expanded(
                            child: Column(
                              children: [
                                if (displayedProducts.length > 1)
                                  _buildManualCard(
                                    context,
                                    displayedProducts[1],
                                  ),
                                const SizedBox(height: 20),
                                if (displayedProducts.length > 3)
                                  _buildManualCard(
                                    context,
                                    displayedProducts[3],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- BOTTOM NAV BAR ---
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  // --- WIDGET: CATEGORY LIST ---
  Widget _buildCategoryList() {
    return SizedBox(
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: ["Trending", "Shoes", "Sweatshirts", "Shirts"].map((cat) {
          bool isSelected = selectedCategory == cat;
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = cat),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? null
                    : Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                cat,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // --- WIDGET: PRODUCT CARD ---
  Widget _buildManualCard(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: product.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage(product.images[0]),
                fit: BoxFit.cover,
                onError: (e, s) {},
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      // THIS IS THE LIKE LOGIC
                      setState(() {
                        product.isFavorite = !product.isFavorite;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      radius: 16,
                      child: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite ? Colors.red : Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  product.price,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET: BOTTOM NAV ---
  Widget _buildBottomNavBar() {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavIcon(Icons.home_filled, true),
          _buildNavIcon(Icons.favorite_border, false),
          _buildNavIcon(Icons.notifications_none, false),
          _buildNavIcon(Icons.person_outline, false),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, bool isActive) {
    return Icon(
      icon,
      color: isActive ? Colors.black : Colors.grey.shade400,
      size: 28,
    );
  }
}
