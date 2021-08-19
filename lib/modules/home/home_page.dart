import 'dart:math';

import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.025,
          ),
          height: screenWidth * 0.95,
          width: screenWidth * 0.95,
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: list.map(
              (columnNumber) {
                return Expanded(
                  child: Row(
                    children: columnNumber % 2 == 0
                        ? mapListToTile(columnNumber, list)
                        : mapListToTile(columnNumber, list.reversed.toList()),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }

  List<TileCard> mapListToTile(int columnNumber, List<int> list) {
    return list.map(
      (rowNumber) {
        return TileCard(
          tile: Tile(
            tileNumber: "${(10 * columnNumber) + rowNumber + 1}",
            isPlayerOneHere: true,
            isPlayerTwoHere: false,
            tileColorValue: generateRandomColorValue(),
          ),
        );
      },
    ).toList();
  }
}
