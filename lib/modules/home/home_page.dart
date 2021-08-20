import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/cobras_escadas/cobras_escadas.dart';
import '../../entities/tile_card/tile_card.dart';
import 'widgets/tile_card.dart';

class HomePage extends StatelessWidget {
  final list = List.generate(10, (index) => index);

  int generateRandomColorValue() {
    final randomDouble = Random().nextDouble();
    final colorValue = (randomDouble * 0xFFFFFF).toInt();
    return colorValue;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => CobrasEscadas(),
      builder: (context, _) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Column(
                children: [
                  Consumer<CobrasEscadas>(
                    builder: (context, provider, _) => Text(
                      "Vez do jogador ${provider.currentPlayer}",
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
                  ElevatedButton(
                    onPressed: () {
                      context.read<CobrasEscadas>().playButtonPressed();
                    },
                    child: Text("Jogar"),
                  ),
                  Consumer<CobrasEscadas>(
                    builder: (context, provider, _) => Text(provider.message),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
                isPlayerOneHere: provider.player1.position == tileNumber,
                isPlayerTwoHere: provider.player2.position == tileNumber,
                tileColorValue: generateRandomColorValue(),
              ),
            );
          },
        );
      },
    ).toList();
  }
}
