// THE PRODUCT MODEL
class Product {
  final String title;
  final String category;
  final String price;
  final String imagePath;
  final String description;
  final double height;

  Product({
    required this.title,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.description,
    required this.height,
  });
}

// HARDCODED DATA (4 Items per category)
List<Product> allProducts = [
  // TRENDING
  Product(
    title: "Men's Pullover Hoodie",
    category: "Trending",
    price: "€97",
    imagePath: "assets/t1.png",
    height: 280,
    description: "Warm, brushed fleece hoodie made for comfort and style.",
  ),
  Product(
    title: "Men's Sport Jersey",
    category: "Trending",
    price: "€68",
    imagePath: "assets/t2.png",
    height: 190,
    description: "Breathable jersey for high-intensity training.",
  ),
  Product(
    title: "Yoga Crewneck",
    category: "Trending",
    price: "€42",
    imagePath: "assets/t3.png",
    height: 190,
    description: "Soft touch crewneck for your daily yoga sessions.",
  ),
  Product(
    title: "Knit Cardigan",
    category: "Trending",
    price: "€94",
    imagePath: "assets/t4.png",
    height: 280,
    description: "Premium knit cardigan for a sophisticated look.",
  ),

  // SHOES
  Product(
    title: "Retro Runner",
    category: "Shoes",
    price: "€120",
    imagePath: "assets/s1.png",
    height: 280,
    description: "Classic running shoes with a vintage aesthetic.",
  ),
  Product(
    title: "White Sneaker",
    category: "Shoes",
    price: "€85",
    imagePath: "assets/s2.png",
    height: 190,
    description: "Clean, minimalist sneakers for any outfit.",
  ),
  Product(
    title: "Air Max Pro",
    category: "Shoes",
    price: "€160",
    imagePath: "assets/s3.png",
    height: 190,
    description: "Ultimate comfort with air-cushion technology.",
  ),
  Product(
    title: "Summer Slide",
    category: "Shoes",
    price: "€45",
    imagePath: "assets/s4.png",
    height: 280,
    description: "Comfortable slides for beach days.",
  ),

  // SWEATSHIRTS
  Product(
    title: "Grey Crewneck",
    category: "Sweatshirts",
    price: "€75",
    imagePath: "assets/sw1.png",
    height: 280,
    description: "Heavy fleece sweatshirt for cold weather.",
  ),
  Product(
    title: "Oversized Fit",
    category: "Sweatshirts",
    price: "€80",
    imagePath: "assets/sw2.png",
    height: 190,
    description: "Trendy oversized fit for street style.",
  ),
  Product(
    title: "Quarter Zip",
    category: "Sweatshirts",
    price: "€90",
    imagePath: "assets/sw3.png",
    height: 190,
    description: "Functional quarter zip for layering.",
  ),
  Product(
    title: "Vintage Wash",
    category: "Sweatshirts",
    price: "€110",
    imagePath: "assets/sw4.png",
    height: 280,
    description: "Unique acid-wash finish.",
  ),

  // SHIRTS
  Product(
    title: "Oxford Button",
    category: "Shirts",
    price: "€65",
    imagePath: "assets/sh1.png",
    height: 280,
    description: "Crisp cotton Oxford for a sharp look.",
  ),
  Product(
    title: "Flannel Plaid",
    category: "Shirts",
    price: "€55",
    imagePath: "assets/sh2.png",
    height: 190,
    description: "Warm flannel for outdoor activities.",
  ),
  Product(
    title: "Linen Shirt",
    category: "Shirts",
    price: "€70",
    imagePath: "assets/sh3.png",
    height: 190,
    description: "Breathable linen for summer comfort.",
  ),
  Product(
    title: "Denim Shirt",
    category: "Shirts",
    price: "€85",
    imagePath: "assets/sh4.png",
    height: 280,
    description: "Durable denim shirt with a modern cut.",
  ),
];
