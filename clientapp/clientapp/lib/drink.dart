import 'package:clientapp/list_item.dart';

class Drink implements ListItem {
  String name;
  double price;

  Drink({this.name, this.price});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }

  Map toJson() => {'name': name, 'price': price};
}
