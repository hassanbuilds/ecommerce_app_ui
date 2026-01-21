import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/fake_dummy_data.dart';
import 'product_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    // FILTER: Only get products where isFavorite is true
    final favoriteProducts = allProducts.where((p) => p.isFavorite).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "My Favorites",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: favoriteProducts.isEmpty
          ? _buildEmptyState()
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return _buildFavoriteCard(product);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 15),
          const Text(
            "No favorites yet",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          const Text("Start liking items to see them here!"),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: product),
          ),
        ).then(
          (_) => setState(() {}),
        ); // Refresh when coming back in case they unliked it
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: product.title,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(product.images[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Unlike button
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        product.isFavorite = false;
                      });
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Icon(Icons.favorite, color: Colors.red, size: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
          Text(product.price, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
