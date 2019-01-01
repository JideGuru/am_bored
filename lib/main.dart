import 'package:Bored/ui/splash.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  var title = "Bored?";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "$title",
      home: Splash(header: "$title",),
//      home: Start(
//        header: "$title",
//      ),
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.red,
      ),
    );
  }
}