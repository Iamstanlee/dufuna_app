import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dufuna/core/failure/exception.dart';

class Http {
  final Dio _dio;
  Http._(Dio dio) : _dio = dio;

  factory Http(Dio dio) {
    dio.options.baseUrl = "https://sfc-lekki-property.herokuapp.com/api";
    dio.options.contentType = 'application/json';
    return Http._(dio);
  }

  Future get(String endpoint, [Map<String, dynamic>? params]) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
      throw ServerException(
          "${response.statusCode}: ${response.statusMessage}");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future post(
    String endpoint,
    dynamic data, {
    bool isFile = false,
    bool usePatch = false,
    bool listen = false,
  }) async {
    try {
      dynamic _data = data;
      // TODO: listen to upload stream
      if (isFile) {
        final file = data as File;
        _data = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            file.path,
            filename: file.path.split("/").last,
          )
        });
      }
      print(endpoint);
      print(_data);
      Response response;
      if (usePatch) {
        response = await _dio.patch(endpoint, data: _data);
      } else {
        response = await _dio.post(endpoint, data: _data);
      }
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return response.data;
      }
      throw "${response.statusCode}: ${response.statusMessage}";
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
