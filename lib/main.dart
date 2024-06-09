import 'package:flutter/material.dart';
import 'package:flappy_birrd/home_page.dart';



void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

  const MyApp({super.key});
  @override
  Widget build(context){
    return const MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}