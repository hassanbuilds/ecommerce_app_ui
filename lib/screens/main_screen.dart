import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The black background shows through the gaps to create the "border" look
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // 1. TOP APP BAR SECTION (Curved only at bottom)
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
                // Search Bar with subtle curves
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search your needs",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color(0xFFF2F2ED),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8), // The black gap from your image
          // 2. MAIN PRODUCT SECTION (Curved at Top and Bottom)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20), // Full soft curve
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
                        _buildCategoryChip("Shoes"),
                        _buildCategoryChip("Sweatshirts"),
                        _buildCategoryChip("Shirts"),
                        _buildCategoryChip("Bags"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Product Grid
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                          ),
                      itemBuilder: (context, index) => _buildProductCard(index),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8), // The black gap
          // 3. BOTTOM NAV BAR (Curved only at top)
          Container(
            height: 90,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
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
        color: isSelected ? Colors.black : const Color(0xFFF2F2ED),
        borderRadius: BorderRadius.circular(25),
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

  Widget _buildProductCard(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2ED),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(Icons.image, size: 50, color: Colors.grey),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(50),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Product Title",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text("€97", style: TextStyle(color: Colors.black54)),
      ],
    );
  }
}
