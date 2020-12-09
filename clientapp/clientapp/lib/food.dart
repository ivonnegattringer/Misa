import 'list_item.dart';

class Food implements ListItem {
  String name;
  double price;
  String ingredients;

  Food({this.name, this.price, this.ingredients});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      price: json['price'].toDouble(),
      ingredients: json['ingredients'],
    );
  }

  Map toJson() => {'name': name, 'price': price, 'ingredients': ingredients};
}
