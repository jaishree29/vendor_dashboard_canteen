// import 'package:flutter/material.dart';
// import 'order_service.dart'; // Import the OrderService class
//
// class OrderDetailsPage extends StatelessWidget {
//   final Map<String, dynamic> order;
//   final OrderService _orderService = OrderService(); // Instantiate the service
//
//   OrderDetailsPage({required this.order});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order ID: ${order['userOrderId']}',
//               style: TextStyle(fontSize: 15),
//             ),
//             SizedBox(height: 10),
//             Center(
//               child: Text(
//                 'Cancellation Status: ${order['cancellationStatus']}',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text('Total Price: \₹${order['totalPrice']}'),
//             SizedBox(height: 20),
//             Text(
//               'Ordered Items:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Column(
//               children: [
//                 ListTile(
//                   title: Text(order['foodTitle']),
//                   subtitle: Text('Quantity: ${order['selectedItems']} - Price: \₹${order['totalPrice']}'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     _orderService.updateOrderStatus(order['userId'], order['userOrderId'], 'Available');
//                   },
//                   child: Text('Confirm Order',style: TextStyle(color: Colors.white)),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _orderService.updateOrderStatus(order['userId'], order['userOrderId'], 'Not Available');
//                   },
//                   child: Text('Reject Order',style: TextStyle(color: Colors.white)),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     _orderService.updateOrderStatus(order['userId'], order['userOrderId'], 'Order Preparing');
//                   },
//                   child: Text('Order Preparing',style: TextStyle(color: Colors.white)),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     _orderService.updateOrderStatus(order['userId'], order['userOrderId'], 'Order Prepared');
//                   },
//                   child: Text('Order Prepared',style: TextStyle(color: Colors.white)),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//                 ),
//               ],
//             ),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   _orderService.updateOrderStatus(order['userId'], order['userOrderId'], 'Order Delivered');
//                 },
//                 child: Text('Order Delivered',style: TextStyle(color: Colors.white),),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }