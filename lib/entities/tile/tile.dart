class Tile {
  final String tileNumber;
  final bool isPlayerOneHere;
  final bool isPlayerTwoHere;
  final bool snakeHeadHere;
  final bool snakeTailHere;
  final bool ladderTopHere;
  final bool ladderBaseHere;
  final int tileColorValue;

  Tile({
    required this.tileNumber,
    required this.isPlayerOneHere,
    required this.isPlayerTwoHere,
    required this.snakeHeadHere,
    required this.snakeTailHere,
    required this.ladderTopHere,
    required this.ladderBaseHere,
    required this.tileColorValue,
  });

  Tile copyWith({
    String? tileNumber,
    bool? isPlayerOneHere,
    bool? isPlayerTwoHere,
    bool? snakeHeadHere,
    bool? snakeTailHere,
    bool? ladderTopHere,
    bool? ladderBaseHere,
    int? tileColorValue,
  }) {
    return Tile(
      tileNumber: tileNumber ?? this.tileNumber,
      isPlayerOneHere: isPlayerOneHere ?? this.isPlayerOneHere,
      isPlayerTwoHere: isPlayerTwoHere ?? this.isPlayerTwoHere,
      snakeHeadHere: snakeHeadHere ?? this.snakeHeadHere,
      snakeTailHere: snakeTailHere ?? this.snakeTailHere,
      ladderTopHere: ladderTopHere ?? this.ladderTopHere,
      ladderBaseHere: ladderBaseHere ?? this.ladderBaseHere,
      tileColorValue: tileColorValue ?? this.tileColorValue,
    );
  }

  @override
  String toString() {
    return 'Tile(tileNumber: $tileNumber, isPlayerOneHere: $isPlayerOneHere, isPlayerTwoHere: $isPlayerTwoHere, snakeHeadHere: $snakeHeadHere, snakeTailHere: $snakeTailHere, ladderTopHere: $ladderTopHere, ladderBaseHere: $ladderBaseHere, tileColorValue: $tileColorValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tile &&
        other.tileNumber == tileNumber &&
        other.isPlayerOneHere == isPlayerOneHere &&
        other.isPlayerTwoHere == isPlayerTwoHere &&
        other.snakeHeadHere == snakeHeadHere &&
        other.snakeTailHere == snakeTailHere &&
        other.ladderTopHere == ladderTopHere &&
        other.ladderBaseHere == ladderBaseHere &&
        other.tileColorValue == tileColorValue;
  }

  @override
  int get hashCode {
    return tileNumber.hashCode ^
        isPlayerOneHere.hashCode ^
        isPlayerTwoHere.hashCode ^
        snakeHeadHere.hashCode ^
        snakeTailHere.hashCode ^
        ladderTopHere.hashCode ^
        ladderBaseHere.hashCode ^
        tileColorValue.hashCode;
  }
}
