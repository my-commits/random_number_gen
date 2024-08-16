import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_number_gen/logic/random_logic.dart';
import 'package:random_number_gen/pages/main_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RandomLogic()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random number',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE28090)),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}