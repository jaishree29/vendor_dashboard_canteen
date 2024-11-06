import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_digital_canteen/orders/global_orders_page.dart';
import 'package:vendor_digital_canteen/orders/widgets/my_card.dart';

import 'order_summary/order_summary_page.dart';

class NewOrderPage extends StatelessWidget {
  const NewOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add the AppBar with a menu icon to open the drawer
      appBar: AppBar(
        title: Text("H e y👋"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

      // Drawer widget
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Center(
                child: Text(
                  'M E N U',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                // Navigate to the Dashboard page
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Order Summary'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OrderSummaryPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                // Navigate to the Profile page
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to the Settings page
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.history_toggle_off),
              title: Text('All Orders'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => GlobalOrdersScreen()),
                );
              },
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 5),
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Header section
              Container(
                width: double.infinity,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Orders", style: TextStyle(fontSize: 25, color: Colors.black87)),
                    Text("Track and Complete Orders", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const Divider(thickness: 1),

              // Completed Orders section
              Container(
                height: 230,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Completed Orders",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // StreamBuilder to fetch completed orders from Firestore
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('global_orders')
                              .where('deliveryStatus', isEqualTo: 'Delivered') // Filter for delivered orders
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Center(child: Text("No completed orders"));
                            }

                            final orders = snapshot.data!.docs;

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: orders.length,
                              itemBuilder: (BuildContext context, int index) {
                                var order = orders[index];
                                return Container(
                                  width: 100,
                                  margin: EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage('assets/images/pasta_img.png'),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            order['foodTitle'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              backgroundColor: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        order['userName'] ?? 'Unknown',  // Default to 'Unknown' if userName is null
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        order['userPhone'] ?? 'Not provided',  // Default to 'Not provided' if userPhone is null
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text("Pending Orders"),
                      Divider(thickness: 1,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Pending Orders section
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('global_orders')
                      .where('deliveryStatus', isEqualTo: 'Pending') // Filter for delivered orders
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No orders found"));
                    }

                    final orders = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> order = orders[index].data() as Map<String, dynamic>;
                        final orderId = orders[index].id;

                        return MyCard(
                          order: order,
                          orderId: orderId,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
