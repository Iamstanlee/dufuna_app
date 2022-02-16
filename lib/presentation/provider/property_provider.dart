import 'dart:io';

import 'package:dufuna/core/model/property.dart';
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
      (failure) => AsyncValue.error(failure.msg),
      (props) {
        // remove props with no image
        asyncValueOfProps = AsyncValue.done(props.fold([], (result, prop) {
          if (prop.images.isNotEmpty) result!.add(prop);
          return result;
        }));
      },
    );
  }

  late AsyncValue<Property> _asyncValueOfUpload;

  AsyncValue<Property> get asyncValueOfUpload => _asyncValueOfUpload;
  set asyncValueOfUpload(AsyncValue<Property> value) {
    _asyncValueOfUpload = value;
    notifyListeners();
  }

  void uploadProp(Property property, [List<File> images = const []]) async {
    List<PropertyImg> uploadedImgs = [];

    asyncValueOfUpload = AsyncValue.loading('Processing images...');

    for (var image in images) {
      final failureOrPropImg = await _propertyRepository.uploadPropImg(image);
      failureOrPropImg.fold((failure) {}, (img) => uploadedImgs.add(img));
    }

    asyncValueOfUpload = AsyncValue.loading('Listing property...');
    final failureOrProp = await _propertyRepository.uploadProp(
        images.isEmpty ? property : property.copyWith(images: uploadedImgs));
    failureOrProp.fold(
      (failure) => asyncValueOfUpload = AsyncValue.error(failure.msg),
      (prop) => asyncValueOfProps =
          AsyncValue.done([prop, ...asyncValueOfProps.data!]),
    );
  }
}
