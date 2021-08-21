class Jogador {
  final int posicao;
  final int numeroDoJogador;

  Jogador({
    required this.posicao,
    required this.numeroDoJogador,
  });

  Jogador copyWith({
    int? posicao,
    int? numeroDoJogador,
  }) {
    return Jogador(
      posicao: posicao ?? this.posicao,
      numeroDoJogador: numeroDoJogador ?? this.numeroDoJogador,
    );
  }

  @override
  String toString() =>
      'Jogador(posicao: $posicao, numeroDoJogador: $numeroDoJogador)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Jogador &&
        other.posicao == posicao &&
        other.numeroDoJogador == numeroDoJogador;
  }

  @override
  int get hashCode => posicao.hashCode ^ numeroDoJogador.hashCode;
}
