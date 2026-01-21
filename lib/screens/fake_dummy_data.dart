class Product {
  final String id; // Add this
  final String title;
  final String category;
  final String price;
  final List<String> images;
  final String description;
  final double height;
  bool isFavorite;
  bool isInCart;
  int quantity;

  Product({
    required this.id, // Add this
    required this.title,
    required this.category,
    required this.price,
    required this.images,
    required this.description,
    required this.height,
    this.isFavorite = false,
    this.isInCart = false,
    this.quantity = 1,
  });
}

//  DUMMY DATA CHART
List<Product> allProducts = [
  // TRENDING
  Product(
    id: "t1", // Unique ID
    title: "Men's Pullover Hoodie",
    category: "Trending",
    price: "€97",
    images: [
      "images/hoodie1.jpg",
      "images/hoodie2.jpg",
      "images/hoodie3.jpg",
      "images/hoodie1.jpg",
      "images/hoodie2.jpg",
    ],
    height: 280,
    description:
        "Celebrate the power and simplicity of the Swoosh. This warm, brushed fleece hoodie is made with some extra room through the shoulders.",
  ),
  Product(
    id: "t2",
    title: "Men's Sport Jersey",
    category: "Trending",
    price: "€68",
    images: [
      "images/sport1.jpg",
      "images/sport2.jpg",
      "images/sport3.jpg",
      "images/sport4.jpg",
      "images/sport5.jpg",
    ],
    height: 190,
    description: "Breathable jersey for high-intensity training.",
  ),
  Product(
    id: "t3",
    title: "Yoga Crewneck",
    category: "Trending",
    price: "€42",
    images: [
      "images/yoga1.jpg",
      "images/yoga2.jpg",
      "images/yoga3.jpg",
      "images/yoga4.jpg",
      "images/yoga5.jpg",
    ],
    height: 190,
    description: "Soft touch crewneck for your daily yoga sessions.",
  ),
  Product(
    id: "t4",
    title: "Knit Cardigan",
    category: "Trending",
    price: "€94",
    images: [
      "images/Knit Cardigan1.png",
      "images/Knit Cardigan2.png",
      "images/Knit Cardigan3.png",
      "images/Knit Cardigan4.png",
      "images/Knit Cardigan5.png",
    ],
    height: 280,
    description: "Premium knit cardigan for a sophisticated look.",
  ),

  // SHOES
  Product(
    id: "s1",
    title: "Retro Runner",
    category: "Shoes",
    price: "€120",
    images: ["images/shoes1.jpg"],
    height: 280,
    description: "Classic running shoes with a vintage aesthetic.",
  ),
  Product(
    id: "s2",
    title: "White Sneaker",
    category: "Shoes",
    price: "€85",
    images: ["images/shoes2.png"],
    height: 190,
    description: "Clean, minimalist sneakers for any outfit.",
  ),
  Product(
    id: "s3",
    title: "Air Max Pro",
    category: "Shoes",
    price: "€160",
    images: ["images/shoes3.png"],
    height: 190,
    description: "Ultimate comfort with air-cushion technology.",
  ),
  Product(
    id: "s4",
    title: "Summer Slide",
    category: "Shoes",
    price: "€45",
    images: ["images4.png"],
    height: 280,
    description: "Comfortable slides for beach days.",
  ),

  // SWEATSHIRTS
  Product(
    id: "sw1",
    title: "Grey Crewneck",
    category: "Sweatshirts",
    price: "€75",
    images: ["images/sweatshirt1.jpg"],
    height: 280,
    description: "Heavy fleece sweatshirt for cold weather.",
  ),
  Product(
    id: "sw2",
    title: "Oversized Fit",
    category: "Sweatshirts",
    price: "€80",
    images: ["images/sweatshirt2.jpg"],
    height: 190,
    description: "Trendy oversized fit for street style.",
  ),
  Product(
    id: "sw3",
    title: "Quarter Zip",
    category: "Sweatshirts",
    price: "€90",
    images: ["images/sweatshirt3.jpg"],
    height: 190,
    description: "Functional quarter zip for layering.",
  ),
  Product(
    id: "sw4",
    title: "Vintage Wash",
    category: "Sweatshirts",
    price: "€110",
    images: ["images/sweatshirt1.jpg"],
    height: 280,
    description: "Unique acid-wash finish.",
  ),

  // SHIRTS
  Product(
    id: "sh1",
    title: "Oxford Button",
    category: "Shirts",
    price: "€65",
    images: ["images/shirt1.jpg"],
    height: 280,
    description: "Crisp cotton Oxford for a sharp look.",
  ),
  Product(
    id: "sh2",
    title: "Flannel Plaid",
    category: "Shirts",
    price: "€55",
    images: ["images/shirt2.jpg"],
    height: 190,
    description: "Warm flannel for outdoor activities.",
  ),
  Product(
    id: "sh3",
    title: "Linen Shirt",
    category: "Shirts",
    price: "€70",
    images: ["images/shirt3.jpg"],
    height: 190,
    description: "Breathable linen for summer comfort.",
  ),
  Product(
    id: "sh4",
    title: "Denim Shirt",
    category: "Shirts",
    price: "€85",
    images: ["images/shirt1.jpg"],
    height: 280,
    description: "Durable denim shirt with a modern cut.",
  ),
];
