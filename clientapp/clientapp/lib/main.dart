import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drink.dart';
import 'food.dart';
import 'food_card.dart';
import 'order.dart';
import 'table.dart';
void main() => runApp(MaterialApp(
    home: Home()
));


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 // final databaseReference = Firestore.instance;

  List<Food> foodsList = [
    Food("Spaghetti", 7.50, "Spaghetti, Bolognese Sauce"),
    Food("Cheeseburger", 3.00, "Rindfleisch, Cheddar Käse, Ketchup")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Misa Restaurant'),
          backgroundColor: Colors.red[400],
        ),
        body: Column(
            children:
          /*  [Text('Registrieren Sie Ihren Tisch, indem sie ein Foto vom Objekt vor Ihnen machen!',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),*/
           foodsList.map((meal) => FoodCard(food: meal)).toList()
            ),
        bottomNavigationBar:
        BottomNavigationBar(type: BottomNavigationBarType.fixed, items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.red,
            ),
            label: "Hauptseite",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.wine_bar_sharp,
                color: Colors.redAccent,
              ),
              label: "Getränke",)
    ,

          BottomNavigationBarItem(
              icon: Icon(
                Icons.restaurant_sharp,
                color: Colors.redAccent,
              ),
              label: "Speisen")
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
            height: 100.0,
            width: 100.0,
            child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Colors.white54,
                  hoverColor: Colors.white38,
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.redAccent,
                  ),
                )
            )
        ),

    );
  }
}


