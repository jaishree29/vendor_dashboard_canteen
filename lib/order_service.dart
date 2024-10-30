import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  // Function to update the order status
  Future<void> updateOrderStatus(String userId, String userOrderId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(userOrderId)
          .update({'orderStatus': status});

      print('Order $userOrderId status updated to $status.');
    } catch (e) {
      print('Error updating order status to $status: $e');
    }
  }

  // Function to delete an order by orderId
  Future<void> deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('global_orders')
          .doc(orderId)
          .delete();

      print('Order $orderId deleted successfully.');
    } catch (e) {
      print('Error deleting order $orderId: $e');
    }
  }
}
