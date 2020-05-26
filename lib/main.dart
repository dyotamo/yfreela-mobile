import 'package:flutter/material.dart';
import 'package:free/src/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YFree',
      home: CategoriesScreen(title: 'Selecione a Categoria'),
    );
  }
}
