import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ML/take_image.dart';
import 'package:camera/camera.dart';
import 'package:cloud_functions/cloud_functions.dart';
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

/*Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e);
  }
  runApp(ML());
} */


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
 class _HomeState extends State<Home> {
  //final databaseReference = Firestore.instance;


  Future<void> getDrinks() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('drinks');
    final results = await callable();
    List drinks = results.data;
    print(drinks);
  }


  void getData() {
  /*  databaseReference
        .collection("drinks")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });*/
  }


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
              label: "Speisen"),
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
                  onPressed: () => getDrinks()
                  /*{ Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => ML(),
                    )
                  );
                  },*/
                ),
            )
        ),


    );
  }
}


