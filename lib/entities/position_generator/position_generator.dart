import 'dart:math';

class PositionGenerator {
  static int generatePosition() {
    final random = Random();
    final number = random.nextInt(100);

    if (number == 0) {
      return generatePosition();
    }

    return number;
  }
}
