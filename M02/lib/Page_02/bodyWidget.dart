import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBodyWidget extends StatefulWidget {
  String? image;
  double value = 0;
  MyBodyWidget({super.key, this.image, required this.value});

  @override
  State<MyBodyWidget> createState() => _MyBodyWidgetState();
}

class _MyBodyWidgetState extends State<MyBodyWidget> {
  late SharedPreferences prefs;
  final String _keyScore = 'score';
  final String _keyImage = 'image';

  String? image;
  double score = 0;
  void loadData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      score = (prefs.getDouble(_keyScore) ?? 0);
      if (widget.image == null) {
        widget.image = prefs.getString(_keyImage);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(color: Colors.red[200]),
            child: widget.image != null
                ? Image.file(
                    File(widget.image!),
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.fitHeight,
                  )
                : Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 198, 198, 198)),
                    width: 200,
                    height: 200,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(
              value: widget.value,
            ),
          )
        ]),
      ),
    );
  }
}
