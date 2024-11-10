import 'package:flutter/material.dart';
import 'package:vendor_digital_canteen/orders/delivered_orders.dart';

import 'package:vendor_digital_canteen/orders/order_summary/order_summary_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Delivered Orders'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DeliveredOrdersPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
