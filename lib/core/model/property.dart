import 'dart:convert';

class PropertyImg {
  final int size;
  final String path;
  final String originalName;
  PropertyImg({
    required this.size,
    required this.path,
    required this.originalName,
  });

  PropertyImg copyWith({
    int? size,
    String? path,
    String? originalName,
  }) {
    return PropertyImg(
      size: size ?? this.size,
      path: path ?? this.path,
      originalName: originalName ?? this.originalName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'path': path,
      'originalname': originalName,
    };
  }

  factory PropertyImg.fromMap(Map<String, dynamic> map) {
    return PropertyImg(
      size: map['size']?.toInt() ?? 0,
      path: map['path'] ?? '',
      originalName: map['originalname'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyImg.fromJson(String source) =>
      PropertyImg.fromMap(json.decode(source));

  @override
  String toString() =>
      'PropertyImg(size: $size, path: $path, originalName: $originalName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PropertyImg &&
        other.size == size &&
        other.path == path &&
        other.originalName == originalName;
  }

  @override
  int get hashCode => size.hashCode ^ path.hashCode ^ originalName.hashCode;
}

class Property {
  final String uid;
  final String address;
  final String type;
  final int bedRoom;
  final int sittingRoom;
  final int bathRoom;
  final int kitchen;
  final int toilet;
  final String owner;
  final String desc;
  final String validFrom;
  final String validTo;
  final List<PropertyImg> images;
  final String createdAt; //
  final String updatedAt; //

  Property({
    required this.uid,
    required this.address,
    required this.type,
    required this.bedRoom,
    required this.sittingRoom,
    required this.bathRoom,
    required this.toilet,
    required this.kitchen,
    required this.owner,
    required this.desc,
    required this.validFrom,
    required this.validTo,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Property.seed() => Property(
        uid: '',
        address: '',
        type: '',
        bedRoom: 0,
        sittingRoom: 0,
        bathRoom: 0,
        toilet: 0,
        kitchen: 0,
        owner: '',
        desc: '',
        validFrom: '',
        validTo: '',
        images: [],
        createdAt: '',
        updatedAt: '',
      );

  Property copyWith({
    String? uid,
    String? address,
    String? type,
    int? bedRoom,
    int? sittingRoom,
    int? bathRoom,
    int? toilet,
    int? kitchen,
    String? owner,
    String? desc,
    String? validFrom,
    String? validTo,
    List<PropertyImg>? images,
    String? createdAt,
    String? updatedAt,
  }) {
    return Property(
      uid: uid ?? this.uid,
      address: address ?? this.address,
      type: type ?? this.type,
      bedRoom: bedRoom ?? this.bedRoom,
      sittingRoom: sittingRoom ?? this.sittingRoom,
      bathRoom: bathRoom ?? this.bathRoom,
      toilet: toilet ?? this.toilet,
      kitchen: kitchen ?? this.kitchen,
      owner: owner ?? this.owner,
      desc: desc ?? this.desc,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': uid,
      'address': address,
      'type': type,
      'bedroom': bedRoom,
      'kitchen': kitchen,
      'sittingRoom': sittingRoom,
      'bathRoom': bathRoom,
      'toilet': toilet,
      'propertyOwner': owner,
      'description': desc,
      'validFrom': validFrom,
      'validTo': validTo,
      'images': images.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      uid: map['_id'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      bedRoom: map['“bedroom”']?.toInt() ?? 0,
      sittingRoom: map['sittingRoom']?.toInt() ?? 0,
      bathRoom: map['bathRoom']?.toInt() ?? 0,
      toilet: map['toilet']?.toInt() ?? 0,
      kitchen: map['kitchen']?.toInt() ?? 0,
      owner: map['propertyOwner'] ?? '',
      desc: map['description'] ?? '',
      validFrom: map['validFrom'] ?? '',
      validTo: map['validTo'] ?? '',
      images: List<PropertyImg>.from(
          map['images']?.map((x) => PropertyImg.fromMap(x))),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Property.fromJson(String source) =>
      Property.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Property(uid: $uid, address: $address, type: $type, bedRoom: $bedRoom, sittingRoom: $sittingRoom, bathRoom: $bathRoom, kitchen: $kitchen, toilet: $toilet, owner: $owner, desc: $desc, validFrom: $validFrom, validTo: $validTo, images: $images, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
