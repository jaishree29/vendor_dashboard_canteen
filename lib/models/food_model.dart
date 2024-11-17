import 'package:vendor_digital_canteen/views/menu/menu_item.dart';

class FoodModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double? time;
  final FoodCategory category;
  final double rating;
  final Map<String, double?> price; // Change to a map

  FoodModel({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.title,
    this.time,
    required this.category,
    required this.rating,
  });

  // Food object to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price, // Directly include the price map
      'time': time,
      'category': category.toString().split('.').last,
      'rating': rating,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      price: Map<String, double?>.from(map['price']), // Convert the map
      time: map['time'],
      category: FoodCategory.values.firstWhere(
        (e) => e.toString() == 'FoodCategory.${map['category']}',
      ),
      rating: map['rating'],
    );
  }

  bool isValid() {
    return title.isNotEmpty &&
        description.isNotEmpty &&
        imageUrl.isNotEmpty &&
        price.isNotEmpty &&
        rating >= 0 &&
        rating <= 5;
  }
}
