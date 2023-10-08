import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class contohStream extends StatefulWidget {
  const contohStream({super.key});

  @override
  State<contohStream> createState() => _contohStreamState();
}

class _contohStreamState extends State<contohStream> {
  late StreamSubscription _sub;
  final Stream _myStream = Stream.periodic(Duration(seconds: 1), (int Count){
    return Count;
  });
  @override
  Widget build(BuildContext context) {
    int persen = 100;
    int getStream = 0;
    double circular = 1;
    return Scaffold(
      appBar: AppBar(title: Text("Contoh Stream")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: CircularPercentIndicator(
              radius: MediaQuery.of(context).size.height / 5,
              lineWidth: 10,
              percent: circular,
              center: Text("$persen %"),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        _sub = _myStream.listen((event) { 
          getStream = int.parse(event.toString());
          setState(() {
            if(persen - getStream <= 0){
              _sub.cancel();
              persen = 0;
              circular = 0;
            }
            else{
              persen = persen-getStream;
              circular = persen/100;
            }
          });
        });
      }, label: Text("Mulai")),
    );
  }
}
