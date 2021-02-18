import 'package:flutter/material.dart';
import 'package:t_flutter_app/screen/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Test work",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
