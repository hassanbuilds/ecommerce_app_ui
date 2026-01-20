class Product {
  final String title;
  final String category;
  final String price;
  final String description;
  final double height; // Controls the staggered look per item

  Product({
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.height,
  });
}

// FULL HARDCODED DATA
List<Product> allProducts = [
  // TRENDING
  Product(
    title: "Classic Hoodie",
    category: "Trending",
    price: "€97",
    height: 340,
    description: "Celebrate the power and simplicity of the Swoosh.",
  ),
  Product(
    title: "Street Jersey",
    category: "Trending",
    price: "€68",
    height: 240,
    description: "Breathable fabric for everyday movement.",
  ),
  Product(
    title: "Yoga Top",
    category: "Trending",
    price: "€42",
    height: 240,
    description: "Soft touch material for maximum comfort.",
  ),
  Product(
    title: "Knit Cardigan",
    category: "Trending",
    price: "€94",
    height: 340,
    description: "Laid-back, nostalgic style for cold days.",
  ),

  // SHOES
  Product(
    title: "Retro Runner",
    category: "Shoes",
    price: "€120",
    height: 340,
    description: "Vintage look with modern cushioning.",
  ),
  Product(
    title: "White Sneaker",
    category: "Shoes",
    price: "€85",
    height: 240,
    description: "Minimalist design that goes with everything.",
  ),
  Product(
    title: "Air Max Pro",
    category: "Shoes",
    price: "€160",
    height: 240,
    description: "The ultimate performance running shoe.",
  ),
  Product(
    title: "Slide Sandal",
    category: "Shoes",
    price: "€40",
    height: 340,
    description: "Easy on, easy off summer essential.",
  ),

  // SWEATSHIRTS
  Product(
    title: "Grey Crewneck",
    category: "Sweatshirts",
    price: "€75",
    height: 340,
    description: "Heavyweight fleece for a premium feel.",
  ),
  Product(
    title: "Oversized Fit",
    category: "Sweatshirts",
    price: "€80",
    height: 240,
    description: "Boxy silhouette for a modern street look.",
  ),
  Product(
    title: "Quarter Zip",
    category: "Sweatshirts",
    price: "€90",
    height: 240,
    description: "Perfect for layering in transitional weather.",
  ),
  Product(
    title: "Vintage Wash",
    category: "Sweatshirts",
    price: "€110",
    height: 340,
    description: "Acid-wash finish for a retro aesthetic.",
  ),

  // SHIRTS
  Product(
    title: "Oxford Button",
    category: "Shirts",
    price: "€65",
    height: 340,
    description: "Crisp cotton for a sharp, clean look.",
  ),
  Product(
    title: "Flannel Plaid",
    category: "Shirts",
    price: "€55",
    height: 240,
    description: "Warm and rugged for the outdoors.",
  ),
  Product(
    title: "Linen Shirt",
    category: "Shirts",
    price: "€70",
    height: 240,
    description: "Light and airy for hot summer nights.",
  ),
  Product(
    title: "Denim Shirt",
    category: "Shirts",
    price: "€85",
    height: 340,
    description: "Durable denim with a tailored fit.",
  ),
];
