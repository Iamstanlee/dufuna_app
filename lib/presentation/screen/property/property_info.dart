import 'package:dufuna/config/constants.dart';
import 'package:dufuna/config/theme.dart';
import 'package:dufuna/core/model/property.dart';
import 'package:dufuna/core/util/date_formatter.dart';
import 'package:dufuna/core/util/extension.dart';
import 'package:dufuna/core/widget/back_button.dart';
import 'package:dufuna/core/widget/gap.dart';
import 'package:dufuna/core/widget/image.dart';
import 'package:dufuna/presentation/screen/property/add_or_edit_property.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PropertyInfoPage extends StatelessWidget {
  final Property property;
  PropertyInfoPage(this.property, {Key? key}) : super(key: key);
  final DateFormatter dateFormatter = DateFormatter.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 270,
                  child: PageView(
                      children: property.images
                          .map(
                            (e) => Hero(
                              tag: ObjectKey(e),
                              child: HostedImage(
                                e.path,
                                width: context.width,
                              ),
                            ),
                          )
                          .toList()),
                ),
                Padding(
                  padding: const EdgeInsets.all(Insets.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            property.desc,
                            style: context.textTheme.subtitle1!.copyWith(
                              fontSize: FontSizes.s16,
                            ),
                          ),
                          Gap.sm,
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Insets.sm, vertical: Insets.xs),
                            decoration: BoxDecoration(
                              color: AppColors.kPrimary,
                              borderRadius: Corners.mdBorder,
                            ),
                            child: Text(
                              property.type,
                              style: context.textTheme.caption!.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Gap.sm,
                      Text(
                        property.address,
                        style: context.textTheme.subtitle1!
                            .copyWith(color: AppColors.kDark.withOpacity(0.6)),
                      ),
                      Gap.sm,
                      Wrap(
                        runSpacing: Insets.sm,
                        spacing: Insets.sm,
                        children: [
                          IconItem(
                            'toilet',
                            PhosphorIcons.toilet,
                            itemCount: property.toilet,
                          ),
                          IconItem(
                            'bathroom',
                            PhosphorIcons.bathtub,
                            itemCount: property.bathRoom,
                          ),
                          IconItem(
                            'kitchen',
                            PhosphorIcons.cookingPot,
                            itemCount: property.kitchen,
                          ),
                          IconItem(
                            'bedroom',
                            PhosphorIcons.bed,
                            itemCount: property.bedRoom,
                          ),
                          IconItem(
                            'sittingroom',
                            PhosphorIcons.houseSimple,
                            itemCount: property.sittingRoom,
                          ),
                        ],
                      ),
                      Gap.md,
                      const Divider(),
                      Gap.sm,
                      Text(
                        'First listed on: ${dateFormatter.datetimeToString(property.createdAt.toDateTime())}',
                      ),
                      Gap.sm,
                      const Divider(),
                      Gap.md,
                      Text(
                        'Valid from: ${dateFormatter.datetimeToString(property.validFrom.toDateTime())} to ${dateFormatter.datetimeToString(property.validTo.toDateTime())}',
                      ),
                      Gap.sm,
                      const Divider(),
                      Gap.md,
                      Text(
                        'Owner: ${property.owner}',
                      ),
                      Gap.md,
                      Gap.md,
                      Text(
                        'Edit this property',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: Colors.blue.shade900,
                          decoration: TextDecoration.underline,
                        ),
                      ).onTap(
                          () => context.push(AddOrEditPropertyPage(property))),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Positioned(
            top: Insets.lg + Insets.md,
            left: Insets.md,
            child: Backbtn(),
          )
        ],
      ),
    );
  }
}

class IconItem extends StatelessWidget {
  final IconData icon;
  final int itemCount;
  final String label;
  const IconItem(this.label, this.icon, {required this.itemCount, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: IconSizes.sm,
        ),
        const Gap(2),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            '$itemCount ${label.pluralize(itemCount)}',
            style:
                context.textTheme.bodyLarge!.copyWith(fontSize: FontSizes.s16),
          ),
        )
      ],
    );
  }
}
