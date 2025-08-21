import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Modern Translator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TranslatorScreen(),
    );
  }
}
