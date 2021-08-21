import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/cobras_escadas/cobras_escadas.dart';
import '../../../entities/tile/tile.dart';

class TileCard extends StatelessWidget {
  final Tile tile;
  const TileCard({Key? key, required this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? snakeIndex;
    int? ladderIndex;
    if (tile.snakeHeadHere || tile.snakeTailHere) {
      snakeIndex = context.read<CobrasEscadas>().snakes.indexWhere(
                (snake) =>
                    snake.head == int.tryParse(tile.tileNumber) ||
                    snake.tail == int.tryParse(tile.tileNumber),
              ) +
          1;
    }

    if (tile.ladderTopHere || tile.ladderBaseHere) {
      ladderIndex = context.read<CobrasEscadas>().ladders.indexWhere(
                (ladder) =>
                    ladder.top == int.tryParse(tile.tileNumber) ||
                    ladder.base == int.tryParse(tile.tileNumber),
              ) +
          1;
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 0.25,
          ),
          color: tile.tileColorValue.withOpacity(0.4),
        ),
        child: Stack(
          children: [
            if (tile.tileNumber == "1")
              Center(
                child: Icon(
                  Icons.arrow_right_alt,
                  color: Colors.black.withOpacity(0.5),
                  size: 30,
                ),
              ),
            if (tile.tileNumber == "100")
              Center(
                child: Icon(
                  Icons.home,
                  color: Colors.black.withOpacity(0.5),
                  size: 30,
                ),
              ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                        tile.tileNumber,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      if (tile.ladderTopHere)
                        Text(
                          "TE$ladderIndex",
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      if (tile.ladderBaseHere)
                        Text(
                          "BE$ladderIndex",
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      if (tile.snakeHeadHere)
                        Text(
                          "CC$snakeIndex",
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      if (tile.snakeTailHere)
                        Text(
                          "RC$snakeIndex",
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: tile.isPlayerOneHere ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: 10,
                    width: 10,
                    color: Colors.black,
                  ),
                ),
                AnimatedOpacity(
                  opacity: tile.isPlayerTwoHere ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
