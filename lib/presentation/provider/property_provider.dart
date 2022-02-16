import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dufuna/core/model/property.dart';
import 'package:dufuna/core/model/property_filter.dart';
import 'package:dufuna/core/util/async_value.dart';
import 'package:dufuna/repository/property_repository.dart';
import 'package:flutter/foundation.dart';

class PropertyProvider with ChangeNotifier {
  final PropertyRepository _propertyRepository;
  PropertyProvider({required PropertyRepository propertyRepository})
      : _propertyRepository = propertyRepository;

  static final AsyncValue<List<Property>> kAsyncValueLoading =
      AsyncValue.loading('Loading properties...');

  AsyncValue<List<Property>> _asyncValueOfProps = kAsyncValueLoading;

  AsyncValue<List<Property>> get asyncValueOfProps => _asyncValueOfProps;
  set asyncValueOfProps(AsyncValue<List<Property>> value) {
    _asyncValueOfProps = value;
    notifyListeners();
  }

  void getProps([Map<String, dynamic>? filter]) async {
    asyncValueOfProps = kAsyncValueLoading;
    final failureOrProps = await _propertyRepository.getProps(filter);
    failureOrProps.fold(
      (failure) => asyncValueOfProps = AsyncValue.error(failure.msg),
      (props) {
        // remove props with no image
        asyncValueOfProps = AsyncValue.done(props.fold([], (result, prop) {
          if (prop.images.isNotEmpty) result!.add(prop);
          return result;
        }));
      },
    );
  }

  AsyncValue<Property>? _asyncValueOfUpload;

  AsyncValue<Property>? get asyncValueOfUpload => _asyncValueOfUpload;
  set asyncValueOfUpload(AsyncValue<Property>? value) {
    _asyncValueOfUpload = value;
    notifyListeners();
  }

  Future<Either<String, Unit>> uploadProp(Property property,
      [bool update = false, List<File> images = const []]) async {
    List<PropertyImg> uploadedImgs = [];

    if (!update) {
      asyncValueOfUpload = AsyncValue.loading('Processing images...');

      for (var image in images) {
        final failureOrPropImg = await _propertyRepository.uploadPropImg(image);
        failureOrPropImg.fold((failure) => null, (img) {
          uploadedImgs.add(img);
        });
      }
    }

    asyncValueOfUpload = AsyncValue.loading(
        update ? 'Updating property...' : 'Listing property...');
    final failureOrProp = await _propertyRepository.uploadProp(
      images.isEmpty || update
          ? property
          : property.copyWith(images: uploadedImgs),
      update: update,
    );
    asyncValueOfUpload = null;
    return failureOrProp.fold(
      (failure) {
        return Left(failure.msg);
      },
      (prop) {
        if (update) {
          asyncValueOfProps = AsyncValue.done(asyncValueOfProps.data!.map((e) {
            if (e == prop) return prop;
            return e;
          }).toList());
        } else {
          asyncValueOfProps =
              AsyncValue.done([prop, ...asyncValueOfProps.data!]);
        }
        return const Right(unit);
      },
    );
  }

  PropertyFilter _propertyFilter = PropertyFilter();

  PropertyFilter get propertyFilter => _propertyFilter;
  set propertyFilter(PropertyFilter value) {
    _propertyFilter = value;
    notifyListeners();
  }

  void applyFilter(PropertyFilter filter) {
    if (filter != propertyFilter) {
      propertyFilter = filter;
      getProps(propertyFilter.getFilters());
    }
  }
}
