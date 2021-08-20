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
  bool showSnakeAlert = false;
  bool showLadderAlert = false;

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

      notifyListeners();
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
      notifyListeners();
    }
  }

  void playButtonPressed() {
    final dados = _rollDice();

    message = jogar(dado1: dados[0], dado2: dados[1]);

    notifyListeners();
  }

  String jogar({required int dado1, required int dado2}) {
    final jogadorAtual = currentPlayer;
    final posicaoAtual =
        (currentPlayer == 1 ? player1.position : player2.position) +
            dado1 +
            dado2;
    movePlayer(steps: dado1 + dado2);
    return 'Jogador $jogadorAtual está na casa $posicaoAtual';
  }
}
