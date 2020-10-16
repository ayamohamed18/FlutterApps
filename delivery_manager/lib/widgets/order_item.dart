
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  double Price;
  String deliverMan;
  String date;
  OrderItem(this.Price,this.deliverMan,this.date);
  @override
  Widget build(BuildContext context) {
    return Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03).add(EdgeInsets.only(bottom:10)),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(deliverMan,
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        subtitle: Text(date),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
                          color: Colors.red,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 30,
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                '$Price\$',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
}}