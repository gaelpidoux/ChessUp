
import 'package:flutter/material.dart' as mat;
import 'ai_game_page.dart';
import 'local_game_page.dart';

class HomePage extends mat.StatelessWidget {
  const HomePage({super.key});

  @override
  mat.Widget build(mat.BuildContext context) {
    return mat.Scaffold(
      backgroundColor: const mat.Color(0xFF2E1B47),
      appBar: mat.AppBar(
        title: const mat.Text("ChessUp - Menu principal"),
      ),
      body: mat.Center(
        child: mat.Column(
          mainAxisAlignment: mat.MainAxisAlignment.center,
          children: [
            mat.ElevatedButton(
              style: mat.ElevatedButton.styleFrom(
                backgroundColor: const mat.Color(0xFF553377),
              ),
              onPressed: () {
                mat.Navigator.push(
                  context,
                  mat.MaterialPageRoute(builder: (_) => const AIGamePage()),
                );
              },
              child: const mat.Text("Jouer contre l'IA", style: mat.TextStyle(color: mat.Colors.white)),
            ),
            const mat.SizedBox(height: 20),
            mat.ElevatedButton(
              style: mat.ElevatedButton.styleFrom(
                backgroundColor: const mat.Color(0xFF553377),
              ),
              onPressed: () {
                mat.Navigator.push(
                  context,
                  mat.MaterialPageRoute(builder: (_) => const LocalGamePage()),
                );
              },
              child: const mat.Text("Jouer 1V1 (local)", style: mat.TextStyle(color: mat.Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
