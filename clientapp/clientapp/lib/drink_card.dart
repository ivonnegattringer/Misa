import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drink.dart';
import 'main.dart' as home;
import 'order_page.dart' as order_page;
import 'order_page.dart';

class DrinkCard extends StatelessWidget {
  final Drink drink;

  DrinkCard({this.drink});

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
                Text(drink.name,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey[800])),
                new Spacer(),
                IconButton(
                  onPressed: () {
                    home.order.drinks.add((drink));
                    if (home.isOnOrderPage) {
                      order_page.drinksFoodsList.add(drink);
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
                          home.order.drinks.remove(drink);
                          order_page.drinksFoodsList.remove(drink);
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
              Text("€ " + drink.price.toString(),
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]))
            ],
          ),
        ));
  }
}
