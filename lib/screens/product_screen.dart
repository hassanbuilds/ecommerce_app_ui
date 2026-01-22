import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/fake_dummy_data.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String selectedSize = "M";
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isWeb = size.width > 850;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: isWeb ? 1200 : double.infinity),
          child: Column(
            children: [
              _buildAppBar(context, isWeb),
              Expanded(child: isWeb ? _buildWebLayout() : _buildMobileLayout()),
              if (!isWeb) _buildAddToCartButton(false),
            ],
          ),
        ),
      ),
    );
  }

  // APP BAR WITH DYNAMIC BADGE
  Widget _buildAppBar(BuildContext context, bool isWeb) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.all(isWeb ? 15 : 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: _buildCircleIcon(Icons.arrow_back),
              ),
              const Text(
                'Product Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildCartBadge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartBadge() {
    // Counts total entries across ALL products
    int totalInCart = allProducts.fold(
      0,
      (sum, p) => sum + p.cartEntries.length,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartScreen()),
        ).then((_) => setState(() {})); // Refresh badge when returning
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildCircleIcon(Icons.shopping_bag_outlined),
          if (totalInCart > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.orange, // Changed to match Main Screen theme
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                child: Text(
                  '$totalInCart',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
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

  // LAYOUTS
  Widget _buildWebLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 6, child: _buildImageSection(true)),
          const SizedBox(width: 20),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(child: _buildDetailsSection(true)),
                const SizedBox(height: 20),
                _buildAddToCartButton(true),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(flex: 5, child: _buildImageSection(false)),
        Expanded(flex: 4, child: _buildDetailsSection(false)),
      ],
    );
  }

  //  CONTENT SECTIONS
  Widget _buildImageSection(bool isWeb) {
    return Container(
      margin: EdgeInsets.all(isWeb ? 0 : 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E0),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Center(
            child: Hero(
              tag: 'product_${widget.product.id}',
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  widget.product.images[selectedImageIndex],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.product.images.length,
                (index) => GestureDetector(
                  onTap: () => setState(() => selectedImageIndex = index),
                  child: _buildThumbnail(
                    selectedImageIndex == index,
                    widget.product.images[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(bool isWeb) {
    return Container(
      margin: EdgeInsets.fromLTRB(isWeb ? 0 : 12, 0, isWeb ? 0 : 12, 10),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E0),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.category,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    Text(
                      widget.product.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.product.price,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Select size",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ["XS", "S", "M", "L", "XL", "XXL"]
                  .map(
                    (size) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () => setState(() => selectedSize = size),
                        child: _buildSizeChip(size, selectedSize == size),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                widget.product.description,
                style: const TextStyle(
                  color: Colors.black54,
                  height: 1.5,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // UPDATED MULTI-SIZE CART LOGIC
  Widget _buildAddToCartButton(bool isWeb) {
    // Check if the CURRENT selected size is already in the list
    bool isThisSpecificSizeInCart = widget.product.cartEntries.any(
      (entry) => entry.size == selectedSize,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWeb ? 0 : 12, vertical: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (isThisSpecificSizeInCart) {
              // Remove only this specific size
              widget.product.cartEntries.removeWhere(
                (entry) => entry.size == selectedSize,
              );
            } else {
              // Add this size as a new entry
              widget.product.cartEntries.add(CartEntry(size: selectedSize));
            }
          });

          ScaffoldMessenger.of(context).clearSnackBars(); // Prevent stacking
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                !isThisSpecificSizeInCart
                    ? "Added $selectedSize to cart!"
                    : "Removed $selectedSize from cart",
              ),
              duration: const Duration(milliseconds: 800),
              backgroundColor: !isThisSpecificSizeInCart
                  ? Colors.black
                  : Colors.redAccent,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isThisSpecificSizeInCart
              ? Colors.redAccent
              : const Color(0xFFC7C7B1),
          minimumSize: const Size(double.infinity, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: Text(
          isThisSpecificSizeInCart
              ? "Remove Size $selectedSize"
              : "Add Size $selectedSize to Cart",
          style: TextStyle(
            color: isThisSpecificSizeInCart ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // HELPERS
  Widget _buildCircleIcon(IconData icon) => Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
      color: Color(0xFFE5E5E0),
      shape: BoxShape.circle,
    ),
    child: Icon(icon, color: Colors.black, size: 22),
  );

  Widget _buildThumbnail(bool isSelected, String path) => AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: const EdgeInsets.symmetric(vertical: 5),
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
    ),
  );

  Widget _buildSizeChip(String size, bool isSelected) => AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    decoration: BoxDecoration(
      color: isSelected ? Colors.black : Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Text(
      size,
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
