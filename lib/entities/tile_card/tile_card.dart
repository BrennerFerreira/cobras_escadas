class Tile {
  final String tileNumber;
  final bool isPlayerOneHere;
  final bool isPlayerTwoHere;
  final int tileColorValue;

  Tile({
    required this.tileNumber,
    required this.isPlayerOneHere,
    required this.isPlayerTwoHere,
    required this.tileColorValue,
  });

  Tile copyWith({
    String? tileNumber,
    bool? isPlayerOneHere,
    bool? isPlayerTwoHere,
    int? tileColorValue,
  }) {
    return Tile(
      tileNumber: tileNumber ?? this.tileNumber,
      isPlayerOneHere: isPlayerOneHere ?? this.isPlayerOneHere,
      isPlayerTwoHere: isPlayerTwoHere ?? this.isPlayerTwoHere,
      tileColorValue: tileColorValue ?? this.tileColorValue,
    );
  }

  @override
  String toString() {
    return 'Tile(tileNumber: $tileNumber, isPlayerOneHere: $isPlayerOneHere, isPlayerTwoHere: $isPlayerTwoHere, tileColorValue: $tileColorValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tile &&
        other.tileNumber == tileNumber &&
        other.isPlayerOneHere == isPlayerOneHere &&
        other.isPlayerTwoHere == isPlayerTwoHere &&
        other.tileColorValue == tileColorValue;
  }

  @override
  int get hashCode {
    return tileNumber.hashCode ^
        isPlayerOneHere.hashCode ^
        isPlayerTwoHere.hashCode ^
        tileColorValue.hashCode;
  }
}
