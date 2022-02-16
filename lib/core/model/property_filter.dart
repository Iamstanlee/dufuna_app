class PropertyFilter {
  final int? sittingRoom;
  final int? bedroom;
  final int? bathroom;
  final int? kitchen;
  final int? toilet;
  PropertyFilter({
    this.bedroom,
    this.sittingRoom,
    this.bathroom,
    this.kitchen,
    this.toilet,
  });

  Map<String, dynamic> getFilters() {
    final map = <String, dynamic>{};
    if (sittingRoom != null) map.putIfAbsent('sittingRoom', () => sittingRoom);
    if (bedroom != null) map.putIfAbsent('bedroom', () => bedroom);
    if (bathroom != null) map.putIfAbsent('bathroom', () => bathroom);
    if (kitchen != null) map.putIfAbsent('kitchen', () => kitchen);
    if (toilet != null) map.putIfAbsent('toilet', () => sittingRoom);
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
}
