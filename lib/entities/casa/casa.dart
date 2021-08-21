import 'package:flutter/material.dart';

class Casa {
  final String numeroDaCasa;
  final bool jogador1EstaNaCasa;
  final bool jogador2EstaNaCasa;
  final bool haCabecaDeCobra;
  final bool haCaudaDeCobra;
  final bool haTopoDeEscada;
  final bool haBaseDeEscada;
  final Color corDaCasa;

  Casa({
    required this.numeroDaCasa,
    required this.jogador1EstaNaCasa,
    required this.jogador2EstaNaCasa,
    required this.haCabecaDeCobra,
    required this.haCaudaDeCobra,
    required this.haTopoDeEscada,
    required this.haBaseDeEscada,
    required this.corDaCasa,
  });

  Casa copyWith({
    String? numeroDaCasa,
    bool? jogador1EstaNaCasa,
    bool? jogador2EstaNaCasa,
    bool? haCabecaDeCobra,
    bool? haCaudaDeCobra,
    bool? haTopoDeEscada,
    bool? haBaseDeEscada,
    Color? corDaCasa,
  }) {
    return Casa(
      numeroDaCasa: numeroDaCasa ?? this.numeroDaCasa,
      jogador1EstaNaCasa: jogador1EstaNaCasa ?? this.jogador1EstaNaCasa,
      jogador2EstaNaCasa: jogador2EstaNaCasa ?? this.jogador2EstaNaCasa,
      haCabecaDeCobra: haCabecaDeCobra ?? this.haCabecaDeCobra,
      haCaudaDeCobra: haCaudaDeCobra ?? this.haCaudaDeCobra,
      haTopoDeEscada: haTopoDeEscada ?? this.haTopoDeEscada,
      haBaseDeEscada: haBaseDeEscada ?? this.haBaseDeEscada,
      corDaCasa: corDaCasa ?? this.corDaCasa,
    );
  }

  @override
  String toString() {
    return 'Casa(numeroDaCasa: $numeroDaCasa, jogador1EstaNaCasa: $jogador1EstaNaCasa, jogador2EstaNaCasa: $jogador2EstaNaCasa, haCabecaDeCobra: $haCabecaDeCobra, haCaudaDeCobra: $haCaudaDeCobra, haTopoDeEscada: $haTopoDeEscada, haBaseDeEscada: $haBaseDeEscada, corDaCasa: $corDaCasa)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Casa &&
        other.numeroDaCasa == numeroDaCasa &&
        other.jogador1EstaNaCasa == jogador1EstaNaCasa &&
        other.jogador2EstaNaCasa == jogador2EstaNaCasa &&
        other.haCabecaDeCobra == haCabecaDeCobra &&
        other.haCaudaDeCobra == haCaudaDeCobra &&
        other.haTopoDeEscada == haTopoDeEscada &&
        other.haBaseDeEscada == haBaseDeEscada &&
        other.corDaCasa == corDaCasa;
  }

  @override
  int get hashCode {
    return numeroDaCasa.hashCode ^
        jogador1EstaNaCasa.hashCode ^
        jogador2EstaNaCasa.hashCode ^
        haCabecaDeCobra.hashCode ^
        haCaudaDeCobra.hashCode ^
        haTopoDeEscada.hashCode ^
        haBaseDeEscada.hashCode ^
        corDaCasa.hashCode;
  }
}
