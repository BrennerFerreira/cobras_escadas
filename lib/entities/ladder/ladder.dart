import '../position_generator/position_generator.dart';

class Ladder {
  final int top;
  final int base;

  Ladder._({required this.top, required this.base});

  factory Ladder() {
    final firstPosition = PositionGenerator.generatePosition();
    final secondPosition = PositionGenerator.generatePosition();

    if (firstPosition > secondPosition) {
      return Ladder._(top: firstPosition, base: secondPosition);
    } else {
      return Ladder._(top: secondPosition, base: firstPosition);
    }
  }
}