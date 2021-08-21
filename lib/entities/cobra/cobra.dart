import '../gerador_de_posicoes/gerador_de_posicoes.dart';

class Cobra {
  final int cabeca;
  final int cauda;

  Cobra._({required this.cabeca, required this.cauda});

  factory Cobra() {
    final primeiraPosicao = GeradorDePosicoes.gerarPosicoes();
    int segundaPosicao = GeradorDePosicoes.gerarPosicoes();

    while (primeiraPosicao == segundaPosicao) {
      segundaPosicao = GeradorDePosicoes.gerarPosicoes();
    }

    if (primeiraPosicao > segundaPosicao) {
      return Cobra._(cabeca: primeiraPosicao, cauda: segundaPosicao);
    } else {
      return Cobra._(cabeca: segundaPosicao, cauda: primeiraPosicao);
    }
  }
}
