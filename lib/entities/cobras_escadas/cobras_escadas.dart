import 'dart:math';

import 'package:flutter/material.dart';

import '../escada/escada.dart';
import '../jogador/jogador.dart';
import '../cobra/cobra.dart';

class CobrasEscadas with ChangeNotifier {
  List<Cobra> cobras = [];
  List<Escada> escadas = [];
  List<Color> cores = [];
  Jogador jogador1 = Jogador(posicao: 1, numeroDoJogador: 1);
  Jogador jogador2 = Jogador(posicao: 1, numeroDoJogador: 2);
  int jogadorAtual = 1;
  int ultimoJogador = 2;
  String mensagem = "Aperte o botão para jogar!";
  String mensagemDados = '';
  bool mostrarAlertaDeCobra = false;
  bool mostrarAlertaDeEscada = false;
  bool jogadaEmAndamento = false;
  bool jogoFinalizado = false;
  Jogador? vencedor;

  CobrasEscadas() {
    _gerarEscadas();
    _gerarCobras();
    _gerarCores();
  }

  List<int> _rolarDados() {
    final dado1 = Random().nextInt(6) + 1;
    final dado2 = Random().nextInt(6) + 1;

    mensagemDados = "Dados: $dado1 + $dado2";

    return [dado1, dado2];
  }

  bool _verificarSePosicaoEstaOcupada(int posicao) {
    final existeCobraNoLugar = cobras.any(
      (cobra) => cobra.cabeca == posicao || cobra.cauda == posicao,
    );

    final existeEscadaNoLugar = escadas.any(
      (escada) => escada.base == posicao || escada.topo == posicao,
    );

    return existeCobraNoLugar || existeEscadaNoLugar;
  }

  Cobra? _haCobraNoLugar(posicao) {
    final haCobraNoLugar =
        cobras.where((cobra) => cobra.cabeca == posicao).toList();

    return haCobraNoLugar.isEmpty ? null : haCobraNoLugar.first;
  }

  Escada? _haEscadaNoLugar(posicao) {
    final haEscadaNoLugar = escadas
        .where(
          (escada) => escada.base == posicao,
        )
        .toList();

    return haEscadaNoLugar.isEmpty ? null : haEscadaNoLugar.first;
  }

  List<int> _gerarValoresDeCores() {
    final List<int> _valoresDeCores = [];

    while (_valoresDeCores.length < 10) {
      final randomDouble = Random().nextDouble();
      final valorDeCor = (randomDouble * 0xFFFFFF).toInt();
      _valoresDeCores.add(valorDeCor);
    }

    return _valoresDeCores;
  }

  void _gerarCores() {
    final valoresDeCores = _gerarValoresDeCores();
    while (cores.length < 100) {
      cores.add(Color(valoresDeCores[Random().nextInt(10)]));
    }
  }

  void _gerarCobras() {
    while (cobras.length < 10) {
      final novaCobra = Cobra();

      if (!_verificarSePosicaoEstaOcupada(novaCobra.cabeca) &&
          !_verificarSePosicaoEstaOcupada(novaCobra.cauda)) {
        cobras.add(novaCobra);
      }
    }
  }

  void _gerarEscadas() {
    while (escadas.length < 10) {
      final novaEscada = Escada();

      if (!_verificarSePosicaoEstaOcupada(novaEscada.topo) &&
          !_verificarSePosicaoEstaOcupada(novaEscada.base)) {
        escadas.add(novaEscada);
      }
    }
  }

  Future<void> moverJogador({required int dado1, required int dado2}) async {
    final passos = dado1 + dado2;
    jogadaEmAndamento = true;
    bool finalAlcancado = false;
    if (jogadorAtual == 1) {
      for (int i = 1; i <= passos; i++) {
        if (jogador1.posicao == 100) {
          finalAlcancado = true;
        }

        jogador1 = jogador1.copyWith(
          posicao: finalAlcancado ? jogador1.posicao - 1 : jogador1.posicao + 1,
        );

        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 600));
      }

      ultimoJogador = 1;
      final posicaoDeCobra = _haCobraNoLugar(jogador1.posicao);
      final posicaoDeEscada = _haEscadaNoLugar(jogador1.posicao);

      if (posicaoDeCobra != null) {
        jogador1 = jogador1.copyWith(
          posicao: posicaoDeCobra.cauda,
        );

        mostrarAlertaDeCobra = true;
        mensagem = "Jogador 1 está na casa ${posicaoDeCobra.cauda}";
      }

      if (posicaoDeEscada != null) {
        jogador1 = jogador1.copyWith(
          posicao: posicaoDeEscada.topo,
        );

        mostrarAlertaDeEscada = true;
        mensagem = "Jogador 1 está na casa ${posicaoDeEscada.topo}";
      }
      if (dado1 != dado2 || jogoFinalizado) {
        jogadorAtual = 2;
      }
    } else {
      for (int i = 1; i <= passos; i++) {
        if (jogador2.posicao == 100) {
          finalAlcancado = true;
        }

        jogador2 = jogador2.copyWith(
          posicao: finalAlcancado ? jogador2.posicao - 1 : jogador2.posicao + 1,
        );

        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 600));
      }

      ultimoJogador = 2;
      final posicaoDeCobra = _haCobraNoLugar(jogador2.posicao);
      final posicaoDeEscada = _haEscadaNoLugar(jogador2.posicao);

      if (posicaoDeCobra != null) {
        jogador2 = jogador2.copyWith(
          posicao: posicaoDeCobra.cauda,
        );

        mostrarAlertaDeCobra = true;
        mensagem = "Jogador 2 está na casa ${posicaoDeCobra.cauda}";
      }

      if (posicaoDeEscada != null) {
        jogador2 = jogador2.copyWith(
          posicao: posicaoDeEscada.topo,
        );

        mostrarAlertaDeEscada = true;
        mensagem = "Jogador 2 está na casa ${posicaoDeEscada.topo}";
      }

      if (dado1 != dado2 || jogoFinalizado) {
        jogadorAtual = 1;
      }
    }

    jogadaEmAndamento = false;
    notifyListeners();
  }

  void botaoJogarPressionado() {
    final dados = _rolarDados();
    mensagem = jogar(dado1: dados[0], dado2: dados[1]);
    notifyListeners();
  }

  String jogar({required int dado1, required int dado2}) {
    final numeroJogadorAtual = jogadorAtual;
    final jogadorQueAcabouDeJogar = jogadorAtual == 1 ? jogador1 : jogador2;
    final posicaoComDados = jogadorQueAcabouDeJogar.posicao + dado1 + dado2;
    late int posicaoAtual;

    if (jogoFinalizado) {
      mensagemDados = '';
      jogadorAtual = jogadorAtual == 1 ? 2 : 1;
      return 'O jogo acabou!';
    }

    if (posicaoComDados > 100) {
      final posicoesAlemDaUltimaCasa = posicaoComDados - 100;
      posicaoAtual = 100 - posicoesAlemDaUltimaCasa;
    } else if (posicaoComDados == 100) {
      jogoFinalizado = true;
      vencedor = jogadorQueAcabouDeJogar;
      moverJogador(dado1: dado1, dado2: dado2);
      return 'Jogador $numeroJogadorAtual venceu!';
    } else {
      posicaoAtual = posicaoComDados;
    }

    moverJogador(dado1: dado1, dado2: dado2);
    return 'Jogador $numeroJogadorAtual está na casa $posicaoAtual';
  }

  void reiniciar() {
    cobras = [];
    escadas = [];
    cores = [];
    jogador1 = Jogador(posicao: 1, numeroDoJogador: 1);
    jogador2 = Jogador(posicao: 1, numeroDoJogador: 2);
    jogadorAtual = 1;
    ultimoJogador = 2;
    mensagem = "Aperte o botão para jogar!";
    mensagemDados = '';
    mostrarAlertaDeCobra = false;
    mostrarAlertaDeEscada = false;
    jogadaEmAndamento = false;
    jogoFinalizado = false;
    vencedor = null;

    _gerarEscadas();
    _gerarCobras();
    _gerarCores();

    notifyListeners();
  }
}
