import 'package:delivery_manager/widgets/charts.dart';
import 'package:delivery_manager/widgets/order_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.05),
                    child: Text(
                      'Deliver Manager',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Charts(),
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children:[ Column(
                        children: [
                          OrderItem(50.00, 'Muhamed Aly', '2.00PM'),
                          OrderItem(100.0, 'Toka Ehab', '3.00PM'),
                          OrderItem(70.00, 'Ahmed Aly', '4.00PM'),
                          OrderItem(80.00, 'Ahmed Aly', '5.00PM'),
                        ],
                      ),
                      ]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){},
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
