import 'package:word_puzzle/features/domain/entities/leader_board_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardRepository {
  static const _key = "leaderboard";

  Future<List<LeaderboardEntry>> getLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];

    return data.map((e) {
      final parts = e.split("|");
      return LeaderboardEntry(parts[0], int.parse(parts[1]));
    }).toList();
  }

  Future<void> addScore(String name, int score) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    list.add("$name|$score");
    prefs.setStringList(_key, list);
  }
}
