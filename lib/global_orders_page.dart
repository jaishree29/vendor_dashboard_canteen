import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_digital_canteen/order_card.dart';
import 'order_details_page.dart';
import 'order_summary_card.dart';
import 'order_summary_page.dart'; // Import the OrderDetailsPage

class GlobalOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // Set the desired height here
        child: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center align horizontally
            children: [
              Text(
                'Orders',
                style: TextStyle(fontSize: 24), // Customize the title text style
              ),
              SizedBox(height: 8), // Space between title and subtitle
              Text(
                'Track and Complete Orders',
                style: TextStyle(fontSize: 18), // Customize the subtitle text style
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('global_orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders found'));
          } else {
            final orders = snapshot.data!.docs;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index].data() as Map<String, dynamic>;
                final orderId = orders[index].id; // Access the document ID here
                return OrderCard(
                  order: order,
                  orderId: orderId, // Pass the document ID as a separate parameter
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to OrderSummaryPage when FAB is pressed
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => OrderSummaryPage()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Order Summary',
      ),
    );

  }
}
