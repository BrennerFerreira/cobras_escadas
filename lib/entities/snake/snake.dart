import '../position_generator/position_generator.dart';

class Snake {
  final int head;
  final int tail;

  Snake._({required this.head, required this.tail});

  factory Snake() {
    final firstPosition = PositionGenerator.generatePosition();
    int secondPosition = PositionGenerator.generatePosition();

    while (firstPosition == secondPosition) {
      secondPosition = PositionGenerator.generatePosition();
    }

    if (firstPosition > secondPosition) {
      return Snake._(head: firstPosition, tail: secondPosition);
    } else {
      return Snake._(head: secondPosition, tail: firstPosition);
    }
  }
}
