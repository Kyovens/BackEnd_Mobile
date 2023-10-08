import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Contoh2 extends StatefulWidget {
  const Contoh2({Key? key}) : super(key: key);

  @override
  State<Contoh2> createState() => _Contoh2State();
}

class _Contoh2State extends State<Contoh2> {
  double circular = 1;
  int persen = 100;
  int getStream = 0;

  final Stream<int> _myStream =
      Stream.periodic(Duration(seconds: 1), (int count) {
    return count;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stream ")),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          final double avaHeight = constraints.maxHeight;
          return StreamBuilder<int>(
              stream: _myStream,
              builder: (context, snapshot) {
                Widget myCircular;
                if (snapshot.hasData) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      myCircular = CircularPercentIndicator(
                          radius: avaHeight / 5,
                          lineWidth: 20,
                          percent: (persen - snapshot.data!) / 100,
                          center: Text(" ${persen - snapshot.data!}%"));
                      break;
                    default:
                      myCircular = Container();
                  }
                } else {
                  myCircular = Container();
                }
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: myCircular),
                    ]);
              });
        }),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }


}
