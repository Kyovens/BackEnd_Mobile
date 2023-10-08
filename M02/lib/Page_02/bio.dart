import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m2/Page_02/bodyWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBio extends StatefulWidget {
  const MyBio({Key? key}) : super(key: key);

  @override
  State<MyBio> createState() => _MyBioState();
}

class _MyBioState extends State<MyBio> {
  final ImagePicker _picker = ImagePicker();
  final String _keyImage = 'image';
  final String _keyScore = 'score';

  var streamController = StreamController<double>();
  XFile? image;
  double score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bio")),
      body: Column(
        children: [
          StreamBuilder(
              stream: streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("object : waiting");
                  return Column(children: [
                    MyBodyWidget(
                      image: null,
                      value: 0.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            _setImage(image?.path);
                            startStream();
                          },
                          child: Text("Take Image")),
                    ),
                  ]);
                } else if (snapshot.connectionState == ConnectionState.active) {
                  print("object : active");
                  return Column(children: [
                    MyBodyWidget(image: null, value: snapshot.data!),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: null, child: Text("Take Image")),
                    ),
                  ]);
                } else if (snapshot.connectionState == ConnectionState.done) {
                  print("object : Done");
                  return Column(children: [
                    MyBodyWidget(image: image?.path, value: 1.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            _setImage(image?.path);
                            setState(() {
                              streamController = StreamController<double>();
                            });
                            startStream();
                          },
                          child: Text("Take Image")),
                    ),
                  ]);
                }
                return Center();
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SpinBox(
              max: 10.0,
              min: 0.0,
              value: score,
              decimals: 1,
              step: 0.1,
              decoration: InputDecoration(labelText: 'Decimals'),
              onChanged: _setScore,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setImage(String? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value != null)
      setState(() {
        prefs.setString(_keyImage, value);
      });
  }

  Future<void> _setScore(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble(_keyScore, value);
      score = ((prefs.getDouble(_keyScore) ?? 0));
    });
  }

  startStream() async {
    // Generate values from 0 to 10
    for (int i = 1; i <= 3; i++) {
      await Future.delayed(Duration(seconds: 1), () async {
        streamController.add(i / 3);
      });
    }
    streamController.close();
    // Close the stream
  }
}
