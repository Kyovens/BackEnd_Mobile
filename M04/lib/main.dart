import 'package:flutter/material.dart';
import 'package:m04/components/httphelper.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RestAPI(),
    );
  }
}

class RestAPI extends StatefulWidget {
  const RestAPI({super.key});

  @override
  State<RestAPI> createState() => _RestAPIState();
}

class _RestAPIState extends State<RestAPI> {
  late String result;
  late HttpHelper helper;

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    result = "";
  }

  @override
  Widget build(BuildContext context) {
    helper.getMovie().then((value) {
      setState(() {
        result = value;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Movie'),
      ),
      body: SingleChildScrollView(
        child: Text("$result"),
      ),
    );
  }
}
