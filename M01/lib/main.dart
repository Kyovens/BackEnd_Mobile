import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const StreamBuilder(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map> data = [];

  Future<List<Map>> getUserData() async {
    data = [
      {'Nama': "Bunny", 'Telepon': '085211059371'},
      {'Nama': 'Funny', 'Telepon': '08694523640'},
      {'Nama': 'Miles', 'Telepon': '08136548792'}
    ];
    await Future.delayed(const Duration(seconds: 3), (() {
      print("${data.length}");
    }));
    return getUserData();
  }

  void getData() {
    setState(() {
      getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Daftar Pengguna'),
            data.isEmpty
                ? Container()
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(data[index]['Nama']),
                                subtitle: Text(data[index]['Telepon']),
                              );
                            })),
                  ),
            ElevatedButton(
              onPressed: () {
                getData();
                print(data);
              },
              child: const Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamBuilder extends StatefulWidget {
  const StreamBuilder({super.key});

  @override
  State<StreamBuilder> createState() => _StreamBuilderState();
}

class _StreamBuilderState extends State<StreamBuilder> {
  bool isReset = false;
  bool isSubscribed = false;
  bool isPlay = false;
  bool isPaused = false;
  late StreamSubscription _sub;
  int percent = 100;
  int getSteam = 0;
  double circular = 1;

  final Stream myStream =
      Stream.periodic(const Duration(seconds: 1), (int count) {
    return count;
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Stream')),
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // final double avaWidth = constraints.maxWidth;
              final double avaHeight = constraints.maxHeight;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: CircularPercentIndicator(
                    radius: avaHeight / 5,
                    lineWidth: 10,
                    percent: circular,
                    center: Text("$percent %"),
                  ))
                ],
              );
            },
          ),
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isPlay = !isPlay;
              });

              if (isPlay) {
                if (!isSubscribed) {
                  isSubscribed = true;
                  _sub = myStream.listen((event) {
                    getSteam = int.parse(event.toString());
                    setState(() {
                      if (percent - getSteam <= 0) {
                        isSubscribed = false;
                        percent = 0;
                        circular = 0;
                      } else {
                        percent = percent - getSteam;
                        circular = percent / 100;
                      }
                    });
                  });
                } else {
                  isPaused = true;
                  _sub.resume();
                }
              } else {
                isPaused = false;
                _sub.pause();
              }
            },
            child: !isPlay ? Icon(Icons.play_arrow) : Icon(Icons.pause),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                isPlay = false;
                isSubscribed = false;
                isPaused = false;
                percent = 100;
                circular = 1.0;
              });
            },
            child: const Icon(Icons.refresh),
          )
        ]));
  }
}
