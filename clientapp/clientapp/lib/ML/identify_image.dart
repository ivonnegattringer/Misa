import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:async';

class DetailScreen extends StatefulWidget {
  final String imagePath;
  DetailScreen(this.imagePath);

  @override
  _DetailScreenState createState() => new _DetailScreenState(imagePath);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState(this.path);

  final String path;

  String recognizedText = "";


  void _initializeVision() async {
    final File imageFile = File(path);

    if (imageFile != null) {
      await _getImageSize(imageFile);
    }


    final FirebaseVisionImage visionImage =
    FirebaseVisionImage.fromFile(imageFile);

    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();

    final List<ImageLabel> labels = await labeler.processImage(visionImage);

    for (ImageLabel label in labels){
      final double confidence = label.confidence;
      setState(() {
        recognizedText = "$recognizedText $label.text  $confidence.toStringAsFixed(2) \n";
        
        print(recognizedText);
      });
    }
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    // Fetching image from path
    final Image image = Image.file(imageFile);

    // Retrieving its size
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );
  }

  @override
  void initState() {
    _initializeVision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      recognizedText
    );
  }
}
