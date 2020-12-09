import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'food.dart';
import 'main.dart' as home;
import 'order_page.dart' as order_page;
import 'order_page.dart';

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
              Row(children: [
                Text(food.name,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey[800])),
                new Spacer(),
                IconButton(
                  onPressed: () {
                    home.order.foods.add((food));
                    if (home.isOnOrderPage) {
                      order_page.drinksFoodsList.add(food);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderPage(),
                          ));
                    }
                  },
                  icon: Icon(Icons.add_outlined),
                  color: Colors.redAccent,
                ),
                home.isOnOrderPage
                    ? IconButton(
                        onPressed: () {
                          home.order.foods.remove(food);
                          order_page.drinksFoodsList.remove(food);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderPage(),
                              ));
                        },
                        icon: Icon(Icons.highlight_remove_outlined),
                        color: Colors.redAccent,
                      )
                    : Text(""),
              ]),
              SizedBox(height: 6.0),
              Text(food.ingredients,
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600])),
              Text("€ " + food.price.toString(),
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]))
            ],
          ),
        ));
  }
}
