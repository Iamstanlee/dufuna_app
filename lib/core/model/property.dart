import 'dart:convert';

class PropertyImg {
  final int size;
  final String path;
  final String originalname;
  final String fieldname;
  final String encoding;
  final String mimetype;
  final String filename;
  PropertyImg({
    required this.size,
    required this.path,
    required this.originalname,
    required this.fieldname,
    required this.encoding,
    required this.mimetype,
    required this.filename,
  });

  PropertyImg copyWith({
    int? size,
    String? path,
    String? originalname,
    String? fieldname,
    String? encoding,
    String? mimetype,
    String? filename,
  }) {
    return PropertyImg(
      size: size ?? this.size,
      path: path ?? this.path,
      originalname: originalname ?? this.originalname,
      fieldname: fieldname ?? this.fieldname,
      encoding: encoding ?? this.encoding,
      mimetype: mimetype ?? this.mimetype,
      filename: filename ?? this.filename,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'path': path,
      'originalname': originalname,
      'fieldname': fieldname,
      'encoding': encoding,
      'mimetype': mimetype,
      'filename': filename,
    };
  }

  factory PropertyImg.fromMap(Map<String, dynamic> map) {
    return PropertyImg(
      size: map['size']?.toInt() ?? 0,
      path: map['path'] ?? '',
      originalname: map['originalname'] ?? '',
      fieldname: map['fieldname'] ?? '',
      encoding: map['encoding'] ?? '',
      mimetype: map['mimetype'] ?? '',
      filename: map['filename'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyImg.fromJson(String source) =>
      PropertyImg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PropertyImg(size: $size, path: $path, originalname: $originalname, fieldname: $fieldname, encoding: $encoding, mimetype: $mimetype, filename: $filename)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PropertyImg &&
        other.size == size &&
        other.path == path &&
        other.originalname == originalname &&
        other.fieldname == fieldname &&
        other.encoding == encoding &&
        other.mimetype == mimetype &&
        other.filename == filename;
  }

  @override
  int get hashCode {
    return size.hashCode ^
        path.hashCode ^
        originalname.hashCode ^
        fieldname.hashCode ^
        encoding.hashCode ^
        mimetype.hashCode ^
        filename.hashCode;
  }
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

  Map<String, dynamic> getUpdateFields() {
    return {
      'bedroom': bedRoom,
      'kitchen': kitchen,
      'sittingRoom': sittingRoom,
      'bathroom': bathRoom,
      'toilet': toilet,
      'description': desc,
      'validTo': validTo,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'type': type,
      'bedroom': bedRoom,
      'kitchen': kitchen,
      'sittingRoom': sittingRoom,
      'bathroom': bathRoom,
      'toilet': toilet,
      'propertyOwner': owner,
      'description': desc,
      'validFrom': validFrom,
      'validTo': validTo,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      uid: map['_id'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      bedRoom: map['bedroom']?.toInt() ?? 0,
      sittingRoom: map['sittingRoom']?.toInt() ?? 0,
      bathRoom: map['bathroom']?.toInt() ?? 0,
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
}
