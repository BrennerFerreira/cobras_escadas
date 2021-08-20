import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/cobras_escadas/cobras_escadas.dart';
import '../../entities/tile/tile.dart';
import 'widgets/tile_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void snakeAlertListener() {
    if (context.read<CobrasEscadas>().showSnakeAlert) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          final lastPlayer = context.read<CobrasEscadas>().lastPlayer == 1
              ? context.read<CobrasEscadas>().player1
              : context.read<CobrasEscadas>().player2;
          return AlertDialog(
            title: Text("Que pena!"),
            content: Text(
              "Você caiu numa casa que tem uma cabeça de cobra! "
              "Retorne até a cauda dela na casa ${lastPlayer.position}!",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<CobrasEscadas>().showSnakeAlert = false;
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void ladderAlertListener() {
    if (context.read<CobrasEscadas>().showLadderAlert) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          final lastPlayer = context.read<CobrasEscadas>().currentPlayer == 1
              ? context.read<CobrasEscadas>().player2
              : context.read<CobrasEscadas>().player1;
          return AlertDialog(
            title: Text("Uhul!"),
            content: Text(
              "Você caiu numa casa que tem a base de uma escada! "
              "Você vai subir até o topo dela na casa ${lastPlayer.position}!",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<CobrasEscadas>().showLadderAlert = false;
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    context.read<CobrasEscadas>()
      ..addListener(snakeAlertListener)
      ..addListener(ladderAlertListener);
    super.initState();
  }

  final list = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<CobrasEscadas>(
                builder: (context, provider, _) => Text(
                  "Vez do jogador ${provider.currentPlayer}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                ),
                height: screenWidth * 0.95,
                width: screenWidth * 0.95,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  verticalDirection: VerticalDirection.up,
                  children: list.map(
                    (columnNumber) {
                      return Expanded(
                        child: Row(
                          children: columnNumber % 2 == 0
                              ? mapListToTile(columnNumber, list)
                              : mapListToTile(
                                  columnNumber, list.reversed.toList()),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              Consumer<CobrasEscadas>(
                builder: (context, provider, _) => ElevatedButton(
                  onPressed: provider.playRunning
                      ? null
                      : () {
                          context.read<CobrasEscadas>().playButtonPressed();
                        },
                  child: Text("Jogar"),
                ),
              ),
              Consumer<CobrasEscadas>(
                builder: (context, provider, _) => Text(provider.message),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Consumer<CobrasEscadas>> mapListToTile(
    int columnNumber,
    List<int> list,
  ) {
    return list.map(
      (rowNumber) {
        return Consumer<CobrasEscadas>(
          builder: (context, provider, _) {
            final tileNumber = (10 * columnNumber) + rowNumber + 1;
            return TileCard(
              tile: Tile(
                tileNumber: "$tileNumber",
                ladderTopHere:
                    provider.ladders.any((ladder) => ladder.top == tileNumber),
                ladderBaseHere:
                    provider.ladders.any((ladder) => ladder.base == tileNumber),
                snakeHeadHere:
                    provider.snakes.any((snake) => snake.head == tileNumber),
                snakeTailHere:
                    provider.snakes.any((snake) => snake.tail == tileNumber),
                isPlayerOneHere: provider.player1.position == tileNumber,
                isPlayerTwoHere: provider.player2.position == tileNumber,
                tileColorValue: provider.colors[tileNumber - 1],
              ),
            );
          },
        );
      },
    ).toList();
  }

  @override
  void dispose() {
    context.read<CobrasEscadas>()
      ..removeListener(snakeAlertListener)
      ..removeListener(ladderAlertListener);
    super.dispose();
  }
}
