import 'package:artguider/view/homepage/gridpage/gridpage.dart';
import 'package:artguider/viewmodel/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BarnaviProvider()),
        ChangeNotifierProvider(create: (_) => CountSeter()),
        ChangeNotifierProvider(create: (_) => Crossset()),
        ChangeNotifierProvider(create: (_) => NumberSet()),
        ChangeNotifierProvider(create: (_) => Uploadimage()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GridPage(),
      ),
    );
  }
}
