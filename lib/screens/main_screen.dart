import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/fake_dummy_data.dart';
import 'package:ecommerce_app/screens/like_items.dart';
import 'package:flutter/material.dart';
import 'product_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedCategory = "Trending";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isWeb = size.width > 800;
    int crossAxisCount = isWeb ? (size.width > 1200 ? 6 : 4) : 2;

    // Filter logic based on category and search text
    List<Product> displayedProducts = allProducts.where((p) {
      final matchesCategory = p.category == selectedCategory;
      final matchesSearch = p.title.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: isWeb ? 1400 : double.infinity),
          child: Column(
            children: [
              _buildTopHeader(isWeb),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        _buildCategoryList(),
                        const SizedBox(height: 20),
                        Expanded(
                          child: displayedProducts.isEmpty
                              ? const Center(child: Text("No products found"))
                              : GridView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 20,
                                        childAspectRatio: isWeb ? 0.75 : 0.65,
                                      ),
                                  itemCount: displayedProducts.length,
                                  itemBuilder: (context, index) =>
                                      _buildProductCard(
                                        context,
                                        displayedProducts[index],
                                      ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildBottomNavBar(isWeb),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader(bool isWeb) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFE5E5E0),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20, isWeb ? 30 : 60, 20, 25),
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
              _buildCartIcon(),
            ],
          ),
          const SizedBox(height: 25),
          TextField(
            onChanged: (value) => setState(() => searchQuery = value),
            decoration: InputDecoration(
              hintText: "Search your needs",
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FIXED: Logic to use cartEntries instead of isInCart
  Widget _buildCartIcon() {
    int totalItemsInCart = allProducts.fold(
      0,
      (sum, p) => sum + p.cartEntries.length,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartScreen()),
        ).then((_) => setState(() {}));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.black,
            size: 28,
          ),
          if (totalItemsInCart > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  '$totalItemsInCart',
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
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: product),
          ),
        ).then((_) => setState(() {}));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Hero(
              tag: 'product_${product.id}',
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: AssetImage(product.images[0]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: () => setState(
                          () => product.isFavorite = !product.isFavorite,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          radius: 16,
                          child: Icon(
                            product.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: product.isFavorite
                                ? Colors.red
                                : Colors.black,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            product.price,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(bool isWeb) {
    return Container(
      height: 70,
      width: isWeb ? 450 : double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavIcon(Icons.home_filled, true, () {}),
          _buildNavIcon(Icons.favorite_border, false, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            ).then((_) => setState(() {}));
          }),
          _buildNavIcon(Icons.notifications_none, false, () {}),
          _buildNavIcon(Icons.person_outline, false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, bool isActive, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          color: isActive ? Colors.black : Colors.grey.shade400,
          size: 28,
        ),
      );

  Widget _buildCategoryList() {
    final List<String> categories = [
      "Trending",
      "Shoes",
      "Sweatshirts",
      "Shirts",
    ];
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          bool isSelected = selectedCategory == cat;
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
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
        },
      ),
    );
  }
}
