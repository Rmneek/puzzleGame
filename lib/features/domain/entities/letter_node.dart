import 'dart:ui';

class LetterNode {
  String char;
  final Offset offset;
  bool selected = false;
  LetterNode(this.char, this.offset);
}
