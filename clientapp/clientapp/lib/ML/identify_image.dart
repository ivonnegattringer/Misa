import 'dart:convert';
import 'package:clientapp/ML/take_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../table.dart' as prefix;
import '../main.dart';

class DetailScreen extends StatefulWidget {
  final String imagePath;

  DetailScreen(this.imagePath);

  @override
  _DetailScreenState createState() => new _DetailScreenState(imagePath);
}

prefix.Table registeredTable;

class _DetailScreenState extends State<DetailScreen> {
  Future<List<prefix.Table>> tablesList;

  Future<List<prefix.Table>> fetchTables() async {
    final response = await http.get(
        'https://us-central1-misa-2021.cloudfunctions.net/rest/Misa/getTables');
    if (response.statusCode == 200) {
      List<prefix.Table> tables = (json.decode(response.body) as List)
          .map((i) => prefix.Table.fromJson(i))
          .toList();
      return tables;
    } else {
      throw Exception('Failed to load the tables');
    }
  }

  Future<bool> tableExists(String label) async {
    List<prefix.Table> tables = await fetchTables();

    for (var table in tables) {
      if (table.tableIdentifier == label) {
        registeredTable = table;
        return true;
      }
    }
    return false;
  }

  _DetailScreenState(this.path);

  final String path;

  String recognizedText = "";
  List<ImageLabel> labelsToChoose = new List<ImageLabel>();

  void _initializeVision() async {
    final File imageFile = File(path);

    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    final List<ImageLabel> labels = await labeler.processImage(visionImage);

    setState(() {
      labelsToChoose = labels.sublist(0, 5);
    });
  }

  @override
  void initState() {
    _initializeVision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Bitte auf das Objekt tippen,\ndas Sie auf dem Tisch sehen!'),
          backgroundColor: Colors.red[400],
        ),
        backgroundColor: Colors.grey[300],
        body: ListView.builder(
            itemCount: labelsToChoose.length,
            itemBuilder: (context, index) {
              ImageLabel label = labelsToChoose[index];
              return GestureDetector(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                            child: Text(label.text,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.grey[800])),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  bool exists = await tableExists(label.text);
                  if (exists == true) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(true),
                        ));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ML(),
                        ));
                  }
                },
              );
            }));
  }
}
