import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Daftar Pengguna:',
            ),
            Text(
              '$_data',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: () {
                  getData();
                                  },
                child: Text("Get User")),
          ],
        ),
      ),
    );
  }

  Future<List<String>> getUserData() async {
    var data = ["a", "b", "c"];
    await Future.delayed(Duration(seconds: 3), () {
      print("Download data done");
    });
    return data;
  }

  void getData() async {
    var result = await getUserData();
    setState(() {
      _data = result;
    });
  }
}
