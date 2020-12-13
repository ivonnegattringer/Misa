import 'dart:convert';

import 'package:clientapp/ML/identify_image.dart' as ig;
import 'package:clientapp/drink_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ML/take_image.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'drink.dart';
import 'food.dart';
import 'food_card.dart';
import 'order.dart';
import 'order_page.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e);
  }
  runApp(MaterialApp(home: Home(false)));
}

List<CameraDescription> cameras = [];
Order order = new Order(
    created: DateTime.now(),
    table: ig.registeredTable,
    drinks: new List<Drink>(),
    foods: new List<Food>(),
    done: false);
bool isOnOrderPage = false;

class Home extends StatefulWidget {
  final bool registered;

  Home(this.registered);

  @override
  _HomeState createState() => new _HomeState(registered);
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  var contents;
  Future<List<Food>> foodsList;
  Future<List<Drink>> drinksList;
  Future<List<Order>> ordersList;

  bool registered;

  _HomeState(this.registered);

  void setContent() {
    if (this.registered == true && contents == null) {
      contents = Column(children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Herzlich Willkommen!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 27))),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Sie haben sich erfolgreich registriert!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 35))),
        Container(margin: const EdgeInsets.only(top: 200.0)),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Sie können hier unten Ihre Speise und Getränke bestellen!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ))),
        Center(
            child: Container(
          height: 50.0,
          width: 50.0,
          child: Icon(
            Icons.arrow_downward_outlined,
            color: Colors.redAccent,
          ),
        )),
      ]);
    } else if (this.registered == false) {
      contents = Column(children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Herzlich Willkommen!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 27))),
        Container(margin: const EdgeInsets.only(top: 20.0, bottom: 100.0)),
        Text("Registrieren Sie Ihren Tisch!",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 35)),
        Center(
            child: Container(
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ML(),
                        ));
                  },
                )))),
        Container(margin: const EdgeInsets.only(top: 70.0)),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Danach können Sie hier unten Ihre Speise und Getränke bestellen",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 20))),
        Center(
            child: Container(
          height: 50.0,
          width: 50.0,
          child: Icon(
            Icons.arrow_downward_outlined,
            color: Colors.redAccent,
          ),
        )),
      ]);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (this.registered == true && index == 0) {
      _selectedIndex = 0;
    }

    switch (_selectedIndex) {
      case 0:
        contents = contents = Column(children: [
          Text("Herzlich Willkommen!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  fontSize: 30)),
          Container(margin: const EdgeInsets.only(top: 20.0, bottom: 20.0)),
          Text("Sie haben sich erfolgreich registriert!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 35)),
          Container(margin: const EdgeInsets.only(top: 150.0)),
        ]);
        break;
      case 1:
        contents = FutureBuilder<List<Drink>>(
            future: drinksList,
            builder: (context, snapshot) {
              List<Drink> drinks = snapshot.data ?? [];
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: drinks.length,
                  itemBuilder: (context, index) {
                    Drink drink = drinks[index];
                    return new DrinkCard(drink: drink);
                  });
            });
        break;
      case 2:
        contents = FutureBuilder<List<Food>>(
            future: foodsList,
            builder: (context, snapshot) {
              List<Food> foods = snapshot.data ?? [];
              return ListView.builder(
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    Food food = foods[index];
                    return new FoodCard(food: food);
                  });
            });
        break;
    }
  }

  Future<List<Food>> fetchFoods() async {
    final response = await http.get(
        'https://us-central1-misa-2021.cloudfunctions.net/rest/Misa/getFoods');

    if (response.statusCode == 200) {
      List<Food> foods = (json.decode(response.body) as List)
          .map((i) => Food.fromJson(i))
          .toList();
      return foods;
    } else {
      throw Exception('Failed to load the meals');
    }
  }

  Future<List<Drink>> fetchDrinks() async {
    final response = await http.get(
        'https://us-central1-misa-2021.cloudfunctions.net/rest/Misa/getDrinks');
    if (response.statusCode == 200) {
      List<Drink> drinks = (json.decode(response.body) as List)
          .map((i) => Drink.fromJson(i))
          .toList();
      return drinks;
    } else {
      throw Exception('Failed to load the drinks');
    }
  }

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(
        'https://us-central1-misa-2021.cloudfunctions.net/rest/Misa/getOrders');

    if (response.statusCode == 200) {
      List<Order> orders = (json.decode(response.body) as List)
          .map((i) => Order.fromJson(i))
          .toList();
      return orders;
    } else {
      throw Exception('Failed to load the orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    foodsList = fetchFoods();
    drinksList = fetchDrinks();
    isOnOrderPage = false;
    setContent();

    return Scaffold(
        appBar: AppBar(
          title: Text('Misa Restaurant'),
          backgroundColor: Colors.red[400],
        ),
        body: contents,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
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
                label: "Getränke",
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.restaurant_sharp,
                    color: Colors.redAccent,
                  ),
                  label: "Speisen"),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped),
        floatingActionButton: this.registered
            ? FloatingActionButton.extended(
                backgroundColor: Colors.redAccent,
                label: Text("Bestellung anzeigen"),
                onPressed: () {
                  isOnOrderPage = true;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(),
                      ));
                })
            : null);
  }
}
