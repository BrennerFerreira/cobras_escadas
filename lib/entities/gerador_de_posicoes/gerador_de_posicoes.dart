import 'dart:math';

class GeradorDePosicoes {
  static int gerarPosicoes() {
    final random = Random();
    return random.nextInt(97) + 2;
  }
}
