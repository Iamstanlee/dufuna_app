import 'package:dartz/dartz.dart';
import 'package:dufuna/core/failure/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputUtils {
  InputUtils._();
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod<String>('TextInput.hide');
  }

  static void unFocus() {
    primaryFocus?.unfocus();
  }

  /// validate a form with it `key`, `next` is called if the form is valid
  static Either<Failure, Unit> validateForm(GlobalKey<FormState> formKey) {
    final formState = formKey.currentState!;
    if (formState.validate()) {
      formState.save();
      return const Right(unit);
    }
    return Left(InputValidationFailure());
  }

  static String? validateField(String? fieldValue) {
    return fieldValue == null || fieldValue.isEmpty
        ? "This field is required"
        : null;
  }

  static String? validateDigits(String? value) {
    final valid = value != null && RegExp(r"^[0-9]+$").hasMatch(value);
    if (!valid) return 'This field must be a digit';
    return null;
  }
}
