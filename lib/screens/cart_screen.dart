import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/fake_dummy_data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Helper to convert price string (e.g., "€120.00") to a double
  double _parsePrice(String priceStr) {
    try {
      return double.parse(priceStr.replaceAll(RegExp(r'[^0-9.]'), ''));
    } catch (e) {
      return 0.0;
    }
  }

  // Calculate the grand total
  double get totalAmount {
    double total = 0;
    for (var product in allProducts.where((p) => p.isInCart)) {
      total += _parsePrice(product.price) * product.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = allProducts.where((p) => p.isInCart).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) =>
                        _buildCartItem(cartItems[index]),
                  ),
                ),
                _buildCheckoutSection(),
              ],
            ),
    );
  }

  Widget _buildCartItem(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(product.images[0]),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // --- DELETE BUTTON ---
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          product.isInCart = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${product.title} removed"),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  product.price,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 10),
                // Quantity Controls
                Row(
                  children: [
                    _buildQtyBtn(Icons.remove, () {
                      setState(() {
                        if (product.quantity > 1) {
                          product.quantity--;
                        } else {
                          product.isInCart = false;
                        }
                      });
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "${product.quantity}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    _buildQtyBtn(Icons.add, () {
                      setState(() {
                        product.quantity++;
                      });
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 20),
          const Text(
            "Your cart is empty",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(0, -5),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                "€${totalAmount.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 65),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Checkout Now",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
