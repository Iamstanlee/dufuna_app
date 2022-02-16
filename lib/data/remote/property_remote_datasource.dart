import 'dart:io';
import 'package:dufuna/core/failure/exception.dart';
import 'package:dufuna/core/model/property.dart';
import 'package:dufuna/core/service/api.dart';

/// Props = Properties :)
abstract class IPropertyRemoteDataSource {
  Future<List<Property>> getProps([Map<String, dynamic>? filter]);
  Future<Property> getPropById(String uid);
  Future<Property> uploadProp(Property property, {bool update = false});
  Future<PropertyImg> uploadPropImage(File img);
}

const kPropEndpoint = '/v1/lekki/property';

class PropertyRemoteDataSource implements IPropertyRemoteDataSource {
  final Http _http;
  PropertyRemoteDataSource(this._http);
  @override
  Future<List<Property>> getProps([Map<String, dynamic>? filter]) async {
    try {
      final response =
          await _http.get(kPropEndpoint, filter) as Map<String, dynamic>;
      return (response['data'] as List)
          .map((e) => Property.fromMap(e))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Property> getPropById(String uid) async {
    try {
      final response =
          await _http.get("$kPropEndpoint/$uid") as Map<String, dynamic>;
      return Property.fromMap(response['data']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PropertyImg> uploadPropImage(File img) async {
    try {
      final response = await _http.post("/v1/lekki/upload", img, isFile: true)
          as Map<String, dynamic>;
      return PropertyImg.fromMap(response['data']);
    } on ServerException catch (e) {
      throw ServerException(e.msg);
    }
  }

  @override
  Future<Property> uploadProp(
    Property property, {
    bool update = false,
  }) async {
    try {
      final endpoint =
          update ? '$kPropEndpoint/${property.uid}' : kPropEndpoint;
      final response = await _http.post(
        endpoint,
        update ? property.getUpdateFields() : property.toJson(),
        usePatch: update,
      ) as Map<String, dynamic>;
      return Property.fromMap(response['data']);
    } on ServerException catch (e) {
      throw ServerException(e.msg);
    }
  }
}
