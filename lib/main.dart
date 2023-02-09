import 'package:apptodo/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';




void main() async {
  
  await Hive.initFlutter();

  //open a box
  var box = await Hive.openBox('mybox');


  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  // This widget is the root of your Sapplication.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
    