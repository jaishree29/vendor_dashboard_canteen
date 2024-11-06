import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'order_summary.dart';
import 'order_summary_card.dart';

class OrderSummaryPage extends StatefulWidget {
  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  late Future<List<OrderSummary>> _orderSummaries;

  @override
  void initState() {
    super.initState();
    _orderSummaries = _fetchOrderSummaries();
  }

  // Fetch and aggregate orders from Firestore
  Future<List<OrderSummary>> _fetchOrderSummaries() async {

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('global_orders')
        .get();

    // Aggregate totals
    Map<String, int> orderCountMap = {};

    for (var doc in snapshot.docs) {
      String foodTitle = doc['foodTitle'];
      int quantity = doc['selectedItems'];

      if (orderCountMap.containsKey(foodTitle)) {
        orderCountMap[foodTitle] = orderCountMap[foodTitle]! + quantity;
      } else {
        orderCountMap[foodTitle] = quantity;
      }
    }

    // Convert map to a list of OrderSummary objects
    return orderCountMap.entries
        .map((entry) => OrderSummary(
      foodTitle: entry.key,
      totalQuantity: entry.value,
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
      ),
      body: FutureBuilder<List<OrderSummary>>(
        future: _orderSummaries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No orders found"));
          } else {
            List<OrderSummary> orderSummaries = snapshot.data!;

            return ListView.builder(
              itemCount: orderSummaries.length,
              itemBuilder: (context, index) {
                final summary = orderSummaries[index];
                 return OrderSummaryCard(
                  foodTitle: summary.foodTitle,
                   totalQuantity: summary.totalQuantity,
                );
              },
            );
          }
        },
      ),
    );
  }
}
