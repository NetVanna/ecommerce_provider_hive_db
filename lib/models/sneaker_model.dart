import 'dart:convert';

// Functions to parse JSON
Sneaker sneakerFromJson(String str) => Sneaker.fromJson(json.decode(str));

List<Sneaker> sneakersFromJson(String str) {
  final List<dynamic> jsonList = json.decode(str);
  return jsonList.map((item) => Sneaker.fromJson(item)).toList();
}

// Sneaker model
class Sneaker {
  final String id;
  final String name;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;
  final List<dynamic> sizes;
  final String price;
  final String description;
  final String title;

  Sneaker({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.sizes,
    required this.price,
    required this.description,
    required this.title,
  });

  factory Sneaker.fromJson(Map<String, dynamic> json) => Sneaker(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    imageUrl: List<String>.from(json["imageUrl"]),
    oldPrice: json["oldPrice"],
    sizes: List<dynamic>.from(json["sizes"]),
    price: json["price"],
    description: json["description"],
    title: json["title"],
  );
}