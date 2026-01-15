import 'package:clean_architecture/features/domain/entities/leader_board_entity.dart';
import 'package:clean_architecture/features/domain/repositories/leaderboard_repository.dart';
import 'package:clean_architecture/features/presentation/widgets/game_card_container.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LeaderboardRepository().getLeaderboard(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final entries = snapshot.data as List<LeaderboardEntry>;

        return ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: entries.length,
          itemBuilder: (_, i) {
            return GameCard(
              child: ListTile(
                leading: Text("#${i + 1}", style: TextStyle(fontSize: 18)),
                title: Text(entries[i].name),
                trailing: Text(
                  entries[i].score.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
