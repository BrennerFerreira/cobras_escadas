import '../gerador_de_posicoes/gerador_de_posicoes.dart';

class Escada {
  final int topo;
  final int base;

  Escada._({required this.topo, required this.base});

  factory Escada() {
    final primeiraPosicao = GeradorDePosicoes.gerarPosicoes();
    int segundaPosicao = GeradorDePosicoes.gerarPosicoes();

    while (primeiraPosicao == segundaPosicao) {
      segundaPosicao = GeradorDePosicoes.gerarPosicoes();
    }

    if (primeiraPosicao > segundaPosicao) {
      return Escada._(topo: primeiraPosicao, base: segundaPosicao);
    } else {
      return Escada._(topo: segundaPosicao, base: primeiraPosicao);
    }
  }

  @override
  String toString() => 'Escada(topo: $topo, base: $base)';
}
