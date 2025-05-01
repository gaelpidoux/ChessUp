import 'package:flutter/material.dart';
import 'game_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChessUp'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Jouer Partie Fun'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GamePage()),
            );
          },
        ),
      ),
    );
  }
}
