import 'package:flutter/material.dart';
import 'screens/mapa_tela.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscar Percurso',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapPage(),
    );
  }
}
