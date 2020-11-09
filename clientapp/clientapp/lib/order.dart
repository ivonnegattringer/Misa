import 'drink.dart';
import 'food.dart';
import 'table.dart';

class Order{
  DateTime created;
  Table table;
  List<Food> foods;
  List<Drink> drinks;
  bool done;


  Order({this.created, this.table, this.foods, this.drinks, this.done});

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      created: json['name'],
      table: json['table'],
      foods: json['foods'],
      drinks: json['drinks'],
      done: json['done']
    );
  }
}