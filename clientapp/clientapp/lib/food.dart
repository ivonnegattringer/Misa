class Food {
  String name;
  int price;
  String ingredients;

  Food({this.name, this.price, this.ingredients});

  factory Food.fromJson(Map<String, dynamic> json){
    return Food(
      name: json['name'],
      price: json['price'],
      ingredients: json['ingredients'],
    );
  }
}