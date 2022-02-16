import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dufuna/core/failure/exception.dart';
import 'package:dufuna/core/failure/failure.dart';
import 'package:dufuna/core/model/property.dart';
import 'package:dufuna/core/service/network_notifier.dart';
import 'package:dufuna/data/remote/property_remote_datasource.dart';

class PropertyRepository {
  final NetworkNotifier _networkNotifier;
  final IPropertyRemoteDataSource _propertyRemoteDataSource;
  PropertyRepository({
    required NetworkNotifier networkNotifier,
    required IPropertyRemoteDataSource propertyRemoteDataSource,
  })  : _networkNotifier = networkNotifier,
        _propertyRemoteDataSource = propertyRemoteDataSource;

  Future<bool> get hasNetwork => _networkNotifier.hasNetwork();

  Future<Either<Failure, List<Property>>> getProps(
      [Map<String, dynamic>? filter]) async {
    if (await hasNetwork) {
      try {
        final props = await _propertyRemoteDataSource.getProps(filter);
        return Right(props);
      } catch (e) {
        return Left(ServerFailure((e as ServerException).msg ?? ''));
      }
    }
    return Left(NetworkFailure());
  }

  Future<Either<Failure, Property>> getPropById(String uid) async {
    if (await hasNetwork) {
      try {
        final prop = await _propertyRemoteDataSource.getPropById(uid);
        return Right(prop);
      } catch (e) {
        return Left(ServerFailure((e as ServerException).msg ?? ''));
      }
    }
    return Left(NetworkFailure());
  }

  Future<Either<Failure, PropertyImg>> uploadPropImg(File file) async {
    if (await hasNetwork) {
      try {
        final prop = await _propertyRemoteDataSource.uploadPropImage(file);
        return Right(prop);
      } catch (e) {
        return Left(ServerFailure((e as ServerException).msg ?? ''));
      }
    }
    return Left(NetworkFailure());
  }

  Future<Either<Failure, Property>> uploadProp(Property p,
      {bool update = false}) async {
    if (await hasNetwork) {
      try {
        final prop =
            await _propertyRemoteDataSource.uploadProp(p, update: update);
        return Right(prop);
      } catch (e) {
        return Left(ServerFailure((e as ServerException).msg ?? ''));
      }
    }
    return Left(NetworkFailure());
  }
}
