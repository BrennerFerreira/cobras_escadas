import 'dart:math';

import 'package:flutter/material.dart';

import '../ladder/ladder.dart';
import '../player/player.dart';
import '../snake/snake.dart';

class CobrasEscadas with ChangeNotifier {
  final List<Snake> snakes = [];
  final List<Ladder> ladders = [];
  Player player1 = Player(position: 1, playerNumber: 1);
  Player player2 = Player(position: 1, playerNumber: 2);
  int currentPlayer = 1;
  String message = "Aperte o botão para jogar!";

  CobrasEscadas() {
    _generateLadders();
    _generateSnakes();
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

  void movePlayer({required int steps}) {
    if (currentPlayer == 1) {
      player1 = player1.copyWith(
        position: player1.position + steps,
      );
      currentPlayer = 2;
    } else {
      player2 = player2.copyWith(
        position: player2.position + steps,
      );
      currentPlayer = 1;
    }
    notifyListeners();
  }

  void playButtonPressed() {
    final dados = _rollDice();

    jogar(dado1: dados[0], dado2: dados[1]);
  }

  String jogar({required int dado1, required int dado2}) {
    print("dado 1: $dado1, dado 2: $dado2, total: ${dado1 + dado2}");
    movePlayer(steps: dado1 + dado2);
    final posicaoAtual =
        currentPlayer == 1 ? player1.position : player2.position;
    return 'Jogador $currentPlayer está na casa $posicaoAtual';
  }
}
