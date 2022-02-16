import 'package:dufuna/config/constants.dart';
import 'package:dufuna/config/theme.dart';
import 'package:dufuna/core/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Backbtn extends StatelessWidget {
  const Backbtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: Corners.smBorder, color: AppColors.kPrimary),
      child: Icon(
        PhosphorIcons.caretLeft,
        size: IconSizes.lg,
        color: AppColors.kScaffold,
      ),
    ).onTap(
      () => context.pop(),
    );
  }
}
