import 'package:clean_architecture/features/presentation/controllers/game_controller.dart';
import 'package:clean_architecture/features/presentation/screens/drag_page.dart';
import 'package:clean_architecture/features/presentation/screens/leaderboard_page.dart';
import 'package:clean_architecture/features/presentation/screens/letter_slot.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Word Puzzle"),
        actions: [
          IconButton(
            icon: Icon(Icons.emoji_events),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (_) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: LeaderboardPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 30),

              Wrap(
                spacing: 8,
                children: List.generate(
                  game.slotsdata.length,
                  (i) => LetterSlot(i),
                ),
              ),

              SizedBox(height: 40),
              Wrap(children: game.letters.map((e) => LetterTile(e)).toList()),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: game.confetti,
              blastDirectionality: BlastDirectionality.explosive,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              child: Icon(Icons.leaderboard),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (_, _, _) => Scaffold(
                      backgroundColor: Colors.black54,
                      body: Center(
                        child: SizedBox(height: 400, child: LeaderboardPage()),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
