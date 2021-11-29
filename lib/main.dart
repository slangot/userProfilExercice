import 'package:flutter/material.dart';
import 'package:mon_profil/interactive_fields.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon profil',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: InteractiveFields(),
    );
  }
}
