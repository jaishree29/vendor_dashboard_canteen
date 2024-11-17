class FoodItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double? time;
  final FoodCategory category;
  final double rating;
  final List<Price> price;

  FoodItem({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.title,
    this.time,
    required this.category,
    required this.rating,
  });

  //Food object to map

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'time': time,
      'category': category.toString().split('.').last,
      'rating': rating,
    };
  }
}

//Quantity
class Price {
  double? halfPrice;
  double? fullPrice;

  Price({required this.fullPrice, required this.halfPrice});
}

//Food Categories

enum FoodCategory {
  burgers,
  desserts,
  drinks,
  snacks,
  chinese,
}
