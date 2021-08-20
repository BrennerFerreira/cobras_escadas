import 'dart:math';

import '../position_generator/position_generator.dart';

class Ladder {
  final int top;
  final int base;

  Ladder._({required this.top, required this.base});

  factory Ladder() {
    final firstPosition = PositionGenerator.generatePosition();
    int secondPosition = PositionGenerator.generatePosition();

    while (firstPosition == secondPosition) {
      secondPosition = PositionGenerator.generatePosition();
    }

    if (firstPosition > secondPosition) {
      return Ladder._(top: firstPosition, base: secondPosition);
    } else {
      return Ladder._(top: secondPosition, base: firstPosition);
    }
  }

  int get baseRowNumber {
    final double rowDouble = (base / 10);
    final int rowNumber = rowDouble.floor();
    if (rowDouble == rowNumber * 1.0) {
      return rowNumber - 1;
    }
    return rowNumber;
  }

  int get topRowNumber {
    final double rowDouble = (top / 10);
    final int rowNumber = rowDouble.floor();
    if (rowDouble == rowNumber * 1.0) {
      return rowNumber - 1;
    }
    return rowNumber;
  }

  int get baseColumnNumber {
    if (baseRowNumber % 2 == 0) {
      return (base % 10) == 0 ? 9 - (base % 10) : (base % 10) - 1;
    } else {
      return (base % 10) == 0 ? base % 10 : 10 - (base % 10);
    }
  }

  int get topColumnNumber {
    if (topRowNumber % 2 == 0) {
      return (top % 10) == 0 ? 9 - (top % 10) : (top % 10) - 1;
    } else {
      return (top % 10) == 0 ? top % 10 : 10 - (top % 10);
    }
  }

  double get baseTopDistance {
    final int eixoX = topColumnNumber - baseColumnNumber;
    final int eixoY = topRowNumber - baseRowNumber;

    return sqrt(pow(eixoX, 2) + pow(eixoY, 2));
  }

  double get angle {
    final int eixoX = topColumnNumber - baseColumnNumber;

    return acos(eixoX / baseTopDistance);
  }

  @override
  String toString() => 'Ladder(top: $top, base: $base)';
}
