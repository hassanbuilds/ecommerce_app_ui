import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // 1. WHITE TOP APP BAR WITH BOTTOM CURVE
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
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
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
                        color: Colors.black,
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

          // 2. MAIN PRODUCT IMAGE CARD
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
                  const Center(
                    child: Icon(Icons.person, size: 280, color: Colors.black12),
                  ),
                  Positioned(
                    right: 15,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => _buildThumbnail(index == 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. PRODUCT DETAILS CARD
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Men's Fleece",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "Pullover Hoodie",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "€97",
                        style: TextStyle(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "XS",
                      "S",
                      "M",
                      "L",
                      "XL",
                      "XXL",
                      "3XL",
                    ].map((s) => _buildSizeChip(s, s == "M")).toList(),
                  ),
                  const SizedBox(height: 15),
                  const Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        "Warm, brushed fleece hoodie made for comfort and style shdu h jashd asuiasnjdui; s djhudshu iasiadns dysgasas aydvadsuydg suy dgsdjsh digsydu sdugsduydysdvtsdbsdvts dbhgwsduywqdbsghdvstg dcsdsxc sxbyh chjcgcvghc.",
                        style: TextStyle(color: Colors.black54, height: 1.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. ADD TO CART BUTTON
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
            child: ElevatedButton(
              onPressed: () {},
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

  Widget _buildThumbnail(bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: const Icon(Icons.person, size: 30, color: Colors.black26),
    );
  }

  Widget _buildSizeChip(String size, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? null : Border.all(color: Colors.black12),
      ),
      child: Text(
        size,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black54,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
