import 'dart:math';

import 'package:flutter/material.dart';

import '../ladder/ladder.dart';
import '../player/player.dart';
import '../snake/snake.dart';

class CobrasEscadas with ChangeNotifier {
  final List<Snake> snakes = [];
  final List<Ladder> ladders = [];
  final List<Color> colors = [];
  Player player1 = Player(position: 1, playerNumber: 1);
  Player player2 = Player(position: 1, playerNumber: 2);
  int currentPlayer = 1;
  String message = "Aperte o botão para jogar!";
  bool showSnakeAlert = false;
  bool showLadderAlert = false;
  bool playRunning = false;
  bool gameFinished = false;
  Player? winner;

  CobrasEscadas() {
    _generateLadders();
    _generateSnakes();
    _generateColors();
  }

  List<int> _rollDice() {
    final dado1 = Random().nextInt(6) + 1;
    final dado2 = Random().nextInt(6) + 1;

    return [dado1, dado2];
  }

  bool _verifyPositionIsTaken(int position) {
    final isThereASnake = snakes.any(
      (snake) => snake.head == position || snake.tail == position,
    );

    final isThereALadder = ladders.any(
      (ladder) => ladder.base == position || ladder.top == position,
    );

    return isThereASnake || isThereALadder;
  }

  Snake? _isThereASnakeHead(position) {
    final isThereASnakeHead = snakes
        .where(
          (snake) => snake.head == position,
        )
        .toList();

    return isThereASnakeHead.isEmpty ? null : isThereASnakeHead.first;
  }

  Ladder? _isThereALadderBase(position) {
    final isThereALadderBase = ladders
        .where(
          (ladder) => ladder.base == position,
        )
        .toList();

    return isThereALadderBase.isEmpty ? null : isThereALadderBase.first;
  }

  List<int> _generateColorValues() {
    final List<int> _colorValues = [];

    while (_colorValues.length < 10) {
      final randomDouble = Random().nextDouble();
      final colorValue = (randomDouble * 0xFFFFFF).toInt();
      _colorValues.add(colorValue);
    }

    return _colorValues;
  }

  void _generateColors() {
    final colorsValues = _generateColorValues();
    while (colors.length < 100) {
      colors.add(Color(colorsValues[Random().nextInt(10)]).withOpacity(0.5));
    }
  }

  void _generateSnakes() {
    while (snakes.length < 10) {
      final newSnake = Snake();

      if (!_verifyPositionIsTaken(newSnake.head) &&
          !_verifyPositionIsTaken(newSnake.tail)) {
        snakes.add(newSnake);
      }
    }
  }

  void _generateLadders() {
    while (ladders.length < 10) {
      final newLadder = Ladder();

      if (!_verifyPositionIsTaken(newLadder.top) &&
          !_verifyPositionIsTaken(newLadder.base)) {
        ladders.add(newLadder);
      }
    }
  }

  Future<void> movePlayer({required int steps}) async {
    playRunning = true;
    bool endReached = false;
    if (currentPlayer == 1) {
      for (int i = 1; i <= steps; i++) {
        if (player1.position == 100) {
          endReached = true;
        }

        player1 = player1.copyWith(
          position: endReached ? player1.position - 1 : player1.position + 1,
        );

        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 600));
      }

      final snakePosition = _isThereASnakeHead(player1.position);
      final ladderPosition = _isThereALadderBase(player1.position);

      if (snakePosition != null) {
        player1 = player1.copyWith(
          position: snakePosition.tail,
        );
        showSnakeAlert = true;
      }

      if (ladderPosition != null) {
        player1 = player1.copyWith(
          position: ladderPosition.top,
        );
        showLadderAlert = true;
      }

      currentPlayer = 2;
    } else {
      for (int i = 1; i <= steps; i++) {
        if (player2.position == 100) {
          endReached = true;
        }

        player2 = player2.copyWith(
          position: endReached ? player2.position - 1 : player2.position + 1,
        );

        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 600));
      }

      final snakePosition = _isThereASnakeHead(player2.position);
      final ladderPosition = _isThereALadderBase(player2.position);

      if (snakePosition != null) {
        player2 = player2.copyWith(
          position: snakePosition.tail,
        );
        showSnakeAlert = true;
      }

      if (ladderPosition != null) {
        player2 = player2.copyWith(
          position: ladderPosition.top,
        );
        showLadderAlert = true;
      }

      currentPlayer = 1;
    }
    playRunning = false;
    notifyListeners();
  }

  void playButtonPressed() {
    final dados = _rollDice();

    message = jogar(dado1: dados[0], dado2: dados[1]);

    notifyListeners();
  }

  String jogar({required int dado1, required int dado2}) {
    final numeroJogadorAtual = currentPlayer;
    final jogadorAtual = currentPlayer == 1 ? player1 : player2;
    late int posicaoAtual;

    if (gameFinished) {
      currentPlayer = currentPlayer == 1 ? 2 : 1;
      if (jogadorAtual.playerNumber == winner!.playerNumber) {
        return 'Você venceu!';
      } else {
        return 'Você perdeu!';
      }
    }

    if (jogadorAtual.position + dado1 + dado2 > 100) {
      final posicoesAlemDaUltimaCasa =
          jogadorAtual.position + dado1 + dado2 - 100;

      posicaoAtual = 100 - posicoesAlemDaUltimaCasa;
    } else if (jogadorAtual.position + dado1 + dado2 == 100) {
      gameFinished = true;
      winner = jogadorAtual;
      movePlayer(steps: dado1 + dado2);
      return 'Jogador $numeroJogadorAtual venceu o jogo!';
    } else {
      posicaoAtual = jogadorAtual.position + dado1 + dado2;
    }

    movePlayer(steps: dado1 + dado2);
    return 'Jogador $numeroJogadorAtual está na casa $posicaoAtual';
  }
}
