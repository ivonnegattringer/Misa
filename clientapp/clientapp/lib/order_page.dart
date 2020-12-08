import 'dart:convert';
import 'package:clientapp/ML/take_image.dart';
import 'package:clientapp/drink_card.dart';
import 'package:clientapp/list_item.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'drink.dart';
import 'food.dart';
import 'food_card.dart';
import 'table.dart' as prefix;
import 'main.dart' as home;

class OrderPage extends StatefulWidget {
  OrderPage();
  @override
  _OrderPageState createState() => new _OrderPageState();
}

prefix.Table registeredTable;
List<ListItem> drinksFoodsList = new List<ListItem>();

class _OrderPageState extends State<OrderPage> {
  _OrderPageState();


  Future<http.Response> createOrder(){
    print(jsonEncode(home.order));
    return http.post("https://us-central1-misa-2021.cloudfunctions.net/rest/Misa/createOrder",
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(home.order));
  }


  @override
  Widget build(BuildContext context) {
    drinksFoodsList = [];
    for(int i = 0; i < home.order.foods.length; i++){
      drinksFoodsList.add(home.order.foods[i]);
    }
    for(int i = 0; i < home.order.drinks.length; i++){
      drinksFoodsList.add(home.order.drinks[i]);
    }

    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: (){
              Navigator.pop(context);
              home.isOnOrderPage = false;
            },
          ),
          title: Text('Ihre Bestellung'),
          backgroundColor: Colors.red[400],
        ),
      body:
      ListView.builder(
        shrinkWrap: true,
      itemCount: drinksFoodsList.length,
        itemBuilder: (context, index) {
          if(drinksFoodsList[index] is Food){
            Food food = drinksFoodsList[index];
            return new FoodCard(food: food);
          }
          else{
            Drink drink = drinksFoodsList[index];
            return new DrinkCard(drink: drink);
          }
        },
      ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            label: Text("Bestellung aufgeben"),
            onPressed: () {
              home.order.created = DateTime.now();
              createOrder();
              home.order.drinks = [];
              home.order.foods = [];
              Navigator.pop(context);
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
