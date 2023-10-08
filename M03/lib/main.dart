import 'package:flutter/material.dart';
import 'package:m03/components/Screen.dart';
import 'package:m03/components/myProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListProductProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Screen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
