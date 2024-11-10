import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveredOrdersPage extends StatelessWidget {
  const DeliveredOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivered Orders"),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('global_orders')
            .where('deliveryStatus', isEqualTo: 'Order Delivered') // Filter for delivered orders
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No delivered orders"));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (BuildContext context, int index) {
              var order = orders[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/delivered.png'), // Replace with your image asset
                  ),
                  title: Text(
                    order['foodTitle'] ?? 'Unknown Food Item',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Customer: ${order['userName'] ?? 'Unknown'}"),
                      Text("Phone: ${order['userPhone'] ?? 'Not provided'}"),
                    ],
                  ),
                  trailing: Text(
                    order['deliveryStatus'],
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // You can add navigation to a detailed order page here, if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}


