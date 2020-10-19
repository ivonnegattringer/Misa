import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'food.dart';

class FoodCard extends StatelessWidget {

  final Food food;
  FoodCard({this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children:[
                  Text(food.name,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[800]
                      )
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_outlined),
                    color: Colors.redAccent,
                  ),
                ]
              ),
              SizedBox(height:6.0),
              Text(
                  food.ingredients,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600]
                  )
              )
            ],
          ),
        )
    );
  }
}