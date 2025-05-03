import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const ChessUpApp());
}

class ChessUpApp extends StatelessWidget {
  const ChessUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChessUp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF2E1B47),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1433),
          foregroundColor: Colors.amber,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
