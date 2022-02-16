import 'package:dufuna/config/constants.dart';
import 'package:flutter/material.dart';

extension StringX on String {
  int toInt() => int.parse(this);
  double toFloat() => double.parse(this);
  DateTime toDateTime() => DateTime.parse(this);

  String pluralize(int length) {
    if (length == 1) return this;
    return "${this}s";
  }

  String titleCaseSingle() => '${this[0].toUpperCase()}${substring(1)}';

  String defaultOnEmpty([String defaultValue = ""]) =>
      isEmpty ? defaultValue : this;
}

extension ContextX on BuildContext {
  double getHeight([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();
  double get width => getWidth();

  TextTheme get textTheme => Theme.of(this).textTheme;

  Future<T?> push<T>(Widget page) =>
      Navigator.push<T>(this, MaterialPageRoute(builder: (context) => page));

  Future<bool> pop<T>([T? result]) => Navigator.maybePop(this, result);

  void showSnack(String msg, [Color? color]) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color ?? AppColors.kError,
      ),
    );
  }
}

extension ClickableX on Widget {
  Widget onTap(VoidCallback action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }
}
