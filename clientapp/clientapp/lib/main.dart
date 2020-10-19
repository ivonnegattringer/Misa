import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ML/take_image.dart';
import 'package:camera/camera.dart';

import 'drink.dart';
import 'food.dart';
import 'food_card.dart';
import 'order.dart';
import 'table.dart';
void main() => runApp(MaterialApp(
    home: Home()
));

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
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter TEst Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 // final databaseReference = Firestore.instance;

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
              label: "Speisen")
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
                )
            )
        ),

    );
  }
}


