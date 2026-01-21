import 'package:ecommerce_app/screens/fake_dummy_data.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // DYNAMIC STATE: These track what the user selects
  String selectedSize = "M";
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // TOP APP BAR
          Container(
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
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: _buildCircleIcon(Icons.arrow_back),
                    ),
                    const Text(
                      'Product',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildCircleIcon(Icons.shopping_bag_outlined),
                  ],
                ),
              ),
            ),
          ),

          //  DYNAMIC IMAGE SECTION WITH HERO ANIMATION
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5E0),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  // Main Hero Image
                  Center(
                    child: Hero(
                      tag: widget
                          .product
                          .title, // Must match the tag in MainScreen!
                      child: Image.asset(
                        widget.product.images[selectedImageIndex],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Side Thumbnails (Vertical List)
                  Positioned(
                    right: 15,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.product.images.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageIndex = index;
                            });
                          },
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
            ),
          ),

          //  PRODUCT DETAILS & DYNAMIC SIZE SELECTOR
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
              padding: const EdgeInsets.all(20),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.category,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          Text(
                            widget.product.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.product.price,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Select size",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Dynamic Size Chips
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ["XS", "S", "M", "L", "XL", "XXL"].map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: _buildSizeChip(size, selectedSize == size),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 15),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        widget.product.description,
                        style: const TextStyle(
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //  ADD TO CART BUTTON
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
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
          ),
        ],
      ),
    );
  }

  // --- REUSABLE WIDGETS ---

  Widget _buildCircleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xFFE5E5E0),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black, size: 20),
    );
  }

  Widget _buildThumbnail(bool isSelected, String path) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
      ),
    );
  }

  Widget _buildSizeChip(String size, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? null : Border.all(color: Colors.black12),
      ),
      child: Text(
        size,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
