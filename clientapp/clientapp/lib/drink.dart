class Drink{
  String name;
  int price;


  Drink({this.name, this.price});

  factory Drink.fromJson(Map<String, dynamic> json){
    return Drink(
      name: json['name'],
      price: json['price'],
    );
  }
}