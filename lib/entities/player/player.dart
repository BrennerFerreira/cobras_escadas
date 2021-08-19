class Player {
  final int position;
  final int playerNumber;

  Player({
    required this.position,
    required this.playerNumber,
  });

  Player copyWith({
    int? position,
    int? playerNumber,
  }) {
    return Player(
      position: position ?? this.position,
      playerNumber: playerNumber ?? this.playerNumber,
    );
  }

  @override
  String toString() =>
      'Player(position: $position, playerNumber: $playerNumber)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Player &&
        other.position == position &&
        other.playerNumber == playerNumber;
  }

  @override
  int get hashCode => position.hashCode ^ playerNumber.hashCode;
}
