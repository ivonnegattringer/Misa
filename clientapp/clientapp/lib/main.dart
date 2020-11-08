import 'dart:convert';

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
import 'table.dart';
Future <void> main() async{
try {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  } on CameraException catch (e) {
  print(e);
}
  runApp(MaterialApp(
  home: Home()
  ));
}

List<CameraDescription> cameras = [];


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

 class _HomeState extends State<Home> {
   int _selectedIndex = 0;
   var contents;
   Future<List<Food>> foodsList;
   Future<List<Drink>> drinksList;
   Future<List<Order>> ordersList;
   List<Food> foodToOrder;

   void setContent(){
     if(contents == null){
       contents =  Column(children: [Text("Herzlich Willkommen im Misa Restaurant!", textAlign: TextAlign.center, style: TextStyle(
           color: Colors.black,
           fontWeight: FontWeight.w400,
           fontStyle: FontStyle.italic,
           fontSize: 30)),
         Container( margin: const EdgeInsets.only(top: 20.0, bottom: 20.0)),
         Text("Registrieren Sie Ihren Tisch!", textAlign: TextAlign.center, style: TextStyle(
           color: Colors.black,
           fontWeight: FontWeight.bold,
           fontSize: 35)),
         Center(child: Container(
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
                 onPressed: () { Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => ML(),
                     )
                 );
                 },
               )))),
         Container( margin: const EdgeInsets.only(top: 150.0)),
         Text("Danach können Sie hier unten Ihre Speise und Getränke bestellen", textAlign: TextAlign.center, style: TextStyle(
             color: Colors.black,
             fontWeight: FontWeight.w300,
             fontSize: 20)),
       ]);
     }
   }

   void _onItemTapped(int index){
     setState(() {
       _selectedIndex = index;
     });

     _selectedIndex = index;
     switch (_selectedIndex) {
       case 0:
         contents =
             Column(children: [Text("Herzlich Willkommen im Misa Restaurant!", textAlign: TextAlign.center, style: TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.w400,
                 fontStyle: FontStyle.italic,
                 fontSize: 30)),
               Container( margin: const EdgeInsets.only(top: 20.0, bottom: 20.0)),
               Text("Registrieren Sie Ihren Tisch!", textAlign: TextAlign.center, style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.bold,
                   fontSize: 35)),
               Center(child: Container(
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
                         onPressed: () { Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => ML(),
                             )
                         );
                         },
                       )))),
               Container( margin: const EdgeInsets.only(top: 150.0)),
               Text("Danach können Sie hier unten Ihre Speise und Getränke bestellen", textAlign: TextAlign.center, style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.w300,
                   fontSize: 20)),
             ]);
         break;
       case 1:
         contents = FutureBuilder<List<Drink>>(
             future: drinksList,
             builder: (context, snapshot){
               List<Drink> drinks = snapshot.data ?? [];
               return ListView.builder(
                   itemCount: drinks.length,
                   itemBuilder: (context, index) {
                     Drink drink = drinks[index];
                     return new DrinkCard(drink: drink);
                   }
               );
             }
         );
         break;
       case 2:
         contents = FutureBuilder<List<Food>>(
             future: foodsList,
             builder: (context, snapshot){
               List<Food> foods = snapshot.data ?? [];
               return ListView.builder(
                   itemCount: foods.length,
                   itemBuilder: (context, index) {
                     Food food = foods[index];
                     return new FoodCard(food: food);
                   }
               );
             }
         );
         break;
     }
   }

   Future<List<Food>> fetchFoods() async {
     final response = await http.get(
         'https://us-central1-misa-2021.cloudfunctions.net/rest/getFoods');

     if (response.statusCode == 200) {
       List<Food> foods = (json.decode(response.body) as List).map((i) =>
           Food.fromJson(i)).toList();
       return foods;
     } else {
       throw Exception('Failed to load the meals');
     }
   }

   Future<List<Drink>> fetchDrinks() async {
     final response = await http.get(
         'https://us-central1-misa-2021.cloudfunctions.net/rest/getDrinks');

     if (response.statusCode == 200) {
       List<Drink> drinks = (json.decode(response.body) as List).map((i) =>
           Drink.fromJson(i)).toList();
       return drinks;
     } else {
       throw Exception('Failed to load the drinks');
     }
   }

   Future<List<Order>> fetchOrders() async {
     final response = await http.get(
         'https://us-central1-misa-2021.cloudfunctions.net/rest/getOrders');

     if (response.statusCode == 200) {
       List<Order> orders = (json.decode(response.body) as List).map((i) =>
           Order.fromJson(i)).toList();
       return orders;
     } else {
       throw Exception('Failed to load the orders');
     }
   }


  @override
  Widget build(BuildContext context) {
     foodsList = fetchFoods();
     drinksList = fetchDrinks();
     setContent();
     //ordersList = fetchOrders();

     return Scaffold(
        appBar: AppBar(
          title: Text('Misa Restaurant'),
          backgroundColor: Colors.red[400],
        ),
        body:
         contents,
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
     );
  }
}


