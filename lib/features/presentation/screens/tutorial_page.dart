import 'package:clean_architecture/features/presentation/screens/game_page.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Drag letters to form words 🎯",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Start Game 🚀"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => GamePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
