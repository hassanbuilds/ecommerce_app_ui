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
    // 1. RESPONSIVE LOGIC
    final size = MediaQuery.of(context).size;
    final bool isWeb = size.width > 850;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          // Constraints for ultra-wide monitors
          constraints: BoxConstraints(maxWidth: isWeb ? 1200 : double.infinity),
          child: Column(
            children: [
              // --- TOP APP BAR ---
              _buildAppBar(context, isWeb),

              // --- MAIN BODY ---
              Expanded(
                child: isWeb
                    ? _buildWebLayout() // Side-by-side for Web
                    : _buildMobileLayout(), // Vertical for Mobile
              ),

              // --- BOTTOM BUTTON (Only for Mobile) ---
              if (!isWeb) _buildAddToCartButton(false),
            ],
          ),
        ),
      ),
    );
  }

  // WEB LAYOUT: Image Left, Details Right
  Widget _buildWebLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Image Section
          Expanded(flex: 6, child: _buildImageSection(true)),
          const SizedBox(width: 20),
          // Right: Details Section
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(child: _buildDetailsSection(true)),
                const SizedBox(height: 20),
                _buildAddToCartButton(true), // Fixed to bottom of right column
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // MOBILE LAYOUT: Image Top, Details Bottom
  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(flex: 5, child: _buildImageSection(false)),
        Expanded(flex: 4, child: _buildDetailsSection(false)),
      ],
    );
  }

  // --- COMPONENT WIDGETS ---

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
              _buildCircleIcon(Icons.shopping_bag_outlined),
            ],
          ),
        ),
      ),
    );
  }

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
              tag: widget.product.title,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  widget.product.images[selectedImageIndex],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Thumbnail List (Changes orientation for Web)
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
          // Scrollable sizes if they don't fit
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ["XS", "S", "M", "L", "XL", "XXL"].map((size) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedSize = size),
                    child: _buildSizeChip(size, selectedSize == size),
                  ),
                );
              }).toList(),
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

  Widget _buildAddToCartButton(bool isWeb) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWeb ? 0 : 12),
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Added $selectedSize to cart!")),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC7C7B1),
          minimumSize: const Size(double.infinity, 70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: const Text(
          "Add to cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // --- HELPERS ---

  Widget _buildCircleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFFE5E5E0),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black, size: 22),
    );
  }

  Widget _buildThumbnail(bool isSelected, String path) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]
            : null,
      ),
    );
  }

  Widget _buildSizeChip(String size, bool isSelected) {
    return AnimatedContainer(
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
}
