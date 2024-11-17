import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_digital_canteen/models/food_model.dart';

class FoodController {
  // Adding food item to firebase
  Future<void> addFoodItem(FoodModel food) async {
    await FirebaseFirestore.instance.collection('menu').add(food.toMap());
  }

  // Converting Firestore document to FoodModel object
  FoodModel fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return FoodModel.fromMap(data);
  }

  // Fetched food items
  Future<List<FoodModel>> fetchFoodItems() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('menu').get();
    return querySnapshot.docs.map((doc) => fromFirestore(doc)).toList();
  }
}
