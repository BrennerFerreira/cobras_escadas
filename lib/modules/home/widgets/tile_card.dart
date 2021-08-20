import 'package:flutter/material.dart';

import '../../../entities/tile_card/tile_card.dart';

class TileCard extends StatelessWidget {
  final Tile tile;
  const TileCard({Key? key, required this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade700,
            width: 0.5,
          ),
          color: Color(tile.tileColorValue).withOpacity(0.5),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(tile.tileNumber),
            ),
            if (tile.isPlayerOneHere)
              Container(
                height: 10,
                width: 10,
                color: Colors.black,
              ),
            if (tile.isPlayerTwoHere)
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              )
          ],
        ),
      ),
    );
  }
}
