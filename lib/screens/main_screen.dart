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
    // FILTER: Find products that match the selected category
    List<Product> displayedProducts = allProducts
        .where((p) => p.category == selectedCategory)
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // 1. TOP APP BAR
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu, color: Colors.black, size: 28),
                    Text(
                      'Lumière',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
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

          // 2. MAIN WHITE SECTION
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
                      children: ["Trending", "Shoes", "Sweatshirts", "Shirts"]
                          .map((cat) {
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => selectedCategory = cat),
                              child: _buildCategoryChip(
                                cat,
                                isSelected: selectedCategory == cat,
                              ),
                            );
                          })
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // THE DYNAMIC GRID
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
                                _buildManualCard(context, displayedProducts[0]),
                                const SizedBox(height: 20),
                                _buildManualCard(context, displayedProducts[2]),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          // RIGHT COLUMN
                          Expanded(
                            child: Column(
                              children: [
                                _buildManualCard(context, displayedProducts[1]),
                                const SizedBox(height: 20),
                                _buildManualCard(context, displayedProducts[3]),
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
              color: const Color(0xFFE5E5E0),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(product.images),
                fit: BoxFit.cover,
                onError:
                    (
                      exception,
                      stackTrace,
                    ) {}, // Prevents crash if image missing
              ),
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
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
          Text(
            product.price,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
