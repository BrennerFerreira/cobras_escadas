import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entities/cobras_escadas/cobras_escadas.dart';
import '../modules/home/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cobras e Escadas',
      home: ChangeNotifierProvider(
        create: (context) => CobrasEscadas(),
        child: HomePage(),
      ),
    );
  }
}
