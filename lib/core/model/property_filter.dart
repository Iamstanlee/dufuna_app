class PropertyFilter {
  final int sittingRoom;
  final int bedroom;
  final int bathroom;
  final int kitchen;
  final int toilet;
  PropertyFilter({
    this.bedroom = 0,
    this.sittingRoom = 0,
    this.bathroom = 0,
    this.kitchen = 0,
    this.toilet = 0,
  });

  Map<String, dynamic> getFilters() {
    final map = <String, dynamic>{};
    if (sittingRoom != 0) map.putIfAbsent('sittingRoom', () => sittingRoom);
    if (bedroom != 0) map.putIfAbsent('bedroom', () => bedroom);
    if (bathroom != 0) map.putIfAbsent('bathroom', () => bathroom);
    if (kitchen != 0) map.putIfAbsent('kitchen', () => kitchen);
    if (toilet != 0) map.putIfAbsent('toilet', () => sittingRoom);
    return map;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PropertyFilter &&
        other.bedroom == bedroom &&
        other.sittingRoom == sittingRoom &&
        other.bathroom == bathroom &&
        other.kitchen == kitchen &&
        other.toilet == toilet;
  }

  @override
  int get hashCode {
    return bedroom.hashCode ^
        sittingRoom.hashCode ^
        bathroom.hashCode ^
        kitchen.hashCode ^
        toilet.hashCode;
  }

  PropertyFilter copyWith({
    int? sittingRoom,
    int? bedroom,
    int? bathroom,
    int? kitchen,
    int? toilet,
  }) {
    return PropertyFilter(
      sittingRoom: sittingRoom ?? this.sittingRoom,
      bedroom: bedroom ?? this.bedroom,
      bathroom: bathroom ?? this.bathroom,
      kitchen: kitchen ?? this.kitchen,
      toilet: toilet ?? this.toilet,
    );
  }
}
