import 'drink.dart';
import 'food.dart';
import 'table.dart';

class Order{
  DateTime created;
  Table table;
  List<Food> foods;
  List<Drink> drinks;
  bool done;

  Order(DateTime created, Table table, List<Food> foods, List<Drink> drinks){
    this.created = created;
    this.table = table;
    this.foods = foods;
    this.drinks = drinks;
    this.done = false;
  }
}