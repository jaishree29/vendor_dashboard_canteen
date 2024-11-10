import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../button/custom_button.dart';
import '../service/order_service.dart';

class MyCard extends StatelessWidget {
   final Map<String, dynamic> order;
   final String orderId;

   final OrderService _orderService = OrderService(); // Instantiate the service

  MyCard({super.key,required this.order,required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),

      height: 150,

      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 140,
                width: 105,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Set the desired radius here
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSs2paowiODEqEOJ082fLEWgrlBjvBlGd2GrQ&s',
                    height: 130, // Define the height of the image
                    width: 100,  // Define the width of the image
                    fit: BoxFit.cover, // Ensures the image fills the container
                  ),
                ),
              ),
              SizedBox(width: 5), // Optional spacing between containers
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 4),
                  height: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(order['foodTitle'],style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 3),
                      Text(
                        order['userName'],
                        style: TextStyle(
                          color: Color(0xFF707070),
                          // Remove the '#' and add '0xFF' at the beginning
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        "Order-ID: ${order['userOrderId']}",
                        style: TextStyle(
                          color: Color(0xFF707070),

                        ),
                      ),

                      SizedBox(height: 3,),

                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              border: Border.all(),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _orderService.deleteOrder(orderId); // Call the delete method on tap
                              },
                              child: Center(
                                child: Icon(
                                  Icons.delete_outline,
                                  size: 20, // Adjust size as needed
                                ),
                              ),
                            ),
                          ),


                          SizedBox(width: 3,),
                          Flexible(
                            child: GestureDetector(
                              onTap: () async {
                                await Future.wait([
                                  _orderService.updateDeliveryStatus(orderId, 'Order ready'),
                                  _orderService.updateOrderStatus(order['userId'], order['userOrderId'], 'Order is Ready'),  // Replace `someOtherMethod` with your actual method
                                ]);
                              },

                              child: Container(
                                height: 40,
                               // width: double.infinity,
                                color: Colors.red,
                                child: Center(
                                  child: Text("Complete Order", style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),

    );
  }
}
