import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_digital_canteen/models/food_model.dart';
import 'package:vendor_digital_canteen/views/menu/menu_controller.dart';
import 'package:vendor_digital_canteen/views/menu/menu_item.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _formKey = GlobalKey<FormState>();
  final FoodController _foodController = FoodController();

  String _title = '';
  String _description = '';
  String _imageUrl = '';
  double? _halfPrice;
  double? _fullPrice;
  double _rating = 0.0;
  FoodCategory _category = FoodCategory.burgers;
  double? _time;

  void _addFoodItem() {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        final id = FirebaseFirestore.instance.collection('menu').doc().id;

        // Create the price map
        Map<String, double?> price = {};
        if (_halfPrice != null) {
          price['half'] = _halfPrice;
        }
        if (_fullPrice != null) {
          price['full'] = _fullPrice;
        }

        final foodItem = FoodModel(
          id: id,
          title: _title,
          description: _description,
          imageUrl: _imageUrl,
          price: price, // Use the price map
          time: _time,
          category: _category,
          rating: _rating,
        );

        if (foodItem.isValid()) {
          _foodController.addFoodItem(foodItem);
          // Reset the form
          _formKey.currentState!.reset();
          setState(() {
            _category = FoodCategory.burgers;
            _rating = 0.0;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid food item data!')),
          );
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Food item added successfully!')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Some error occurred!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Food Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Enter Title' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter Description' : null,
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) => value!.isEmpty ? 'Enter Image URL' : null,
                onSaved: (value) => _imageUrl = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    _fullPrice = value!.isNotEmpty ? double.parse(value) : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Half Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    _halfPrice = value!.isNotEmpty ? double.parse(value) : null,
              ),
              DropdownButtonFormField<FoodCategory>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: FoodCategory.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.toString().split('.').last),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  double? val = double.tryParse(value!);
                  return (val == null || val < 0 || val > 5)
                      ? 'Enter a valid rating (0-5)'
                      : null;
                },
                onSaved: (value) => _rating = double.parse(value!),
              ),
              TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Estimated Delivery Time (minutes)'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _time = double.parse(value!)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addFoodItem,
                child: const Text("Add Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
