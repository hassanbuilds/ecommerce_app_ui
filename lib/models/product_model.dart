class CartEntry {
  String size;
  int quantity;
  CartEntry({required this.size, this.quantity = 1});
}

class Product {
  final String id;
  final String title;
  final String category;
  final String price;
  final List<String> images;
  final String description;
  final double height;
  bool isFavorite;

  // This stores each size/quantity combo for this product
  List<CartEntry> cartEntries = [];

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.images,
    required this.description,
    required this.height,
    this.isFavorite = false,
  });
}
