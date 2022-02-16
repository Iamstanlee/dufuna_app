import 'package:dufuna/config/constants.dart';
import 'package:dufuna/config/theme.dart';
import 'package:dufuna/core/model/property.dart';
import 'package:dufuna/core/util/date_formatter.dart';
import 'package:dufuna/core/util/extension.dart';
import 'package:dufuna/core/widget/gap.dart';
import 'package:dufuna/core/widget/image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

const kHeight = SizedBox(height: 7);

class PropertyItem extends StatelessWidget {
  final Property property;
  final Function onTap;
  PropertyItem(this.property, {required this.onTap, Key? key})
      : super(key: key);

  final DateFormatter dateFormatter = DateFormatter.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: const EdgeInsets.symmetric(
        vertical: Insets.sm,
        horizontal: Insets.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          kHeight,
          Hero(
            tag: ObjectKey(property.images.first),
            child: ClipRRect(
              borderRadius: Corners.smBorder,
              child: HostedImage(property.images.first.path, height: 200),
            ),
          ),
          kHeight,
          Text(
            property.desc,
            maxLines: 1,
            style: context.textTheme.subtitle1!.copyWith(
              color: AppColors.kDark,
              fontSize: FontSizes.s16,
            ),
          ),
          kHeight,
          Row(
            children: [
              const Icon(PhosphorIcons.bed, size: IconSizes.sm),
              const Gap(2),
              Text(property.bedRoom.toString()),
              Gap.sm,
              const Icon(PhosphorIcons.toilet, size: IconSizes.sm),
              const Gap(2),
              Text(property.toilet.toString()),
              const Spacer(),
              Text('Posted ${dateFormatter.relativeToNow(property.createdAt)}')
            ],
          )
        ],
      ),
    ).onTap(() => onTap());
  }
}
