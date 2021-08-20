import 'dart:math';

class PositionGenerator {
  static int generatePosition() {
    final random = Random();
    return random.nextInt(97) + 2;
  }
}
