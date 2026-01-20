import 'package:flutter/material.dart';
import 'product_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // 1. TOP APP BAR SECTION
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFE5E5E0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu, color: Colors.black, size: 28),
                    const Text(
                      'Lumière',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search your needs",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 2. MAIN PRODUCT SECTION (MANUAL STAGGERED LAYOUT)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  // Category List
                  SizedBox(
                    height: 45,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildCategoryChip("Trending", isSelected: true),
                        _buildCategoryChip("Shoes", isSelected: false),
                        _buildCategoryChip("Sweatshirts", isSelected: false),
                        _buildCategoryChip("Shirts", isSelected: false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // THE MANUAL GRID FIX
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // LEFT COLUMN
                          Expanded(
                            child: Column(
                              children: [
                                // Index 0: TALL
                                _buildManualCard(
                                  context,
                                  "Men's Pullover Hoodie",
                                  "€97",
                                  280,
                                ),
                                const SizedBox(height: 20),
                                // Index 2: SHORT
                                _buildManualCard(
                                  context,
                                  "Yoga Crewneck",
                                  "€42",
                                  190,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ), // Horizontal gap between columns
                          // RIGHT COLUMN
                          Expanded(
                            child: Column(
                              children: [
                                // Index 1: SHORT
                                _buildManualCard(
                                  context,
                                  "Men's Sport Jersey",
                                  "€68",
                                  190,
                                ),
                                const SizedBox(height: 20),
                                // Index 3: TALL
                                _buildManualCard(
                                  context,
                                  "Knit Cardigan",
                                  "€94",
                                  280,
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

          const SizedBox(height: 8),

          // 3. BOTTOM NAV BAR
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.home_filled, color: Colors.black, size: 30),
                Icon(Icons.favorite_border, color: Colors.black54, size: 30),
                Icon(Icons.settings_outlined, color: Colors.black54, size: 30),
                Icon(Icons.person_outline, color: Colors.black54, size: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: isSelected ? null : Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Helper method for manual height control
  Widget _buildManualCard(
    BuildContext context,
    String title,
    String price,
    double height,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductScreen()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  right: 12,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.black.withOpacity(0.5),
                    size: 22,
                  ),
                ),
                const Center(
                  child: Icon(Icons.person, size: 60, color: Colors.black12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
