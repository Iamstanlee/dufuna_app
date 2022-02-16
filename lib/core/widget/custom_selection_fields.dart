import 'dart:io';
import 'package:dufuna/config/constants.dart';
import 'package:dufuna/config/theme.dart';
import 'package:dufuna/core/util/date_formatter.dart';
import 'package:dufuna/core/util/extension.dart';
import 'package:dufuna/core/widget/button.dart';
import 'package:dufuna/core/widget/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

List<String> types = ['flat', 'duplex', 'bungalow', 'single-room'];
List<int> numOfToilets = List.generate(5, (index) => ++index);
List<int> numOfSittingrooms = List.generate(5, (index) => ++index);
List<int> numOfBedrooms = List.generate(5, (index) => ++index);
List<int> numOfKitchens = List.generate(3, (index) => ++index);
List<int> numOfBathrooms = List.generate(4, (index) => ++index);

class InputSelectionItem<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  const InputSelectionItem({
    required this.value,
    required this.groupValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Insets.md),
      decoration: BoxDecoration(
        borderRadius: Corners.smBorder,
        border: Border.all(
          color: value == groupValue ? AppColors.kDark : AppColors.kGrey200,
          width: value == groupValue ? 2 : 1.2,
        ),
      ),
      child: Center(
          child: Text(
        value.toString(),
        style: context.textTheme.bodyLarge!.copyWith(
          color: value == groupValue
              ? AppColors.kDark
              : AppColors.kDark.withOpacity(0.7),
        ),
      )),
    );
  }
}

class InputSelectionField<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T groupValue;
  final ValueChanged<T> onChanged;
  const InputSelectionField(this.title,
      {required this.items,
      required this.groupValue,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.md),
          child: Text(
            title,
            style:
                context.textTheme.bodyLarge!.copyWith(color: AppColors.kDark),
          ),
        ),
        Gap.md,
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) {
              final value = items[i];
              return Padding(
                padding: EdgeInsets.only(
                  left: i == 0 ? Insets.md : Insets.sm,
                  right: i == items.length - 1 ? Insets.md : 0,
                ),
                child: InputSelectionItem(value: value, groupValue: groupValue)
                    .onTap(() => onChanged(value)),
              );
            },
            itemCount: items.length,
          ),
        )
      ],
    );
  }
}

class DateSelectionField extends StatefulWidget {
  final String title;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;
  const DateSelectionField(this.title,
      {required this.value, required this.onChanged, Key? key})
      : super(key: key);

  @override
  State<DateSelectionField> createState() => _DateSelectionFieldState();
}

class _DateSelectionFieldState extends State<DateSelectionField> {
  final DateFormatter dateFormatter = DateFormatter.instance;

  late DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style:
                context.textTheme.bodyLarge!.copyWith(color: AppColors.kDark),
          ),
          Gap.md,
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.kGrey,
                width: 1.4,
              ),
              borderRadius: Corners.smBorder,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.md,
              vertical: Insets.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateFormatter.datetimeToString(widget.value),
                  style: context.textTheme.bodyMedium!
                      .copyWith(color: Colors.black, fontSize: FontSizes.s16),
                ),
                const Icon(PhosphorIcons.caretDown)
              ],
            ),
          ).onTap(() async {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => Container(
                color: AppColors.kScaffold,
                height: context.getHeight(0.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        minimumDate:
                            widget.value.subtract(const Duration(days: 1)),
                        initialDateTime: widget.value,
                        onDateTimeChanged: (value) => date = value,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Insets.md),
                      child: Button(
                        'SELECT THIS DATE',
                        onTap: (() {
                          widget.onChanged(date);
                          context.pop();
                        }),
                      ),
                    ),
                    const Gap(44)
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

class ImageSelectionField extends StatelessWidget {
  final List<File> images;
  final ValueChanged<File> onAdd;
  final ValueChanged<int> onRemove;
  const ImageSelectionField(
    this.images, {
    required this.onAdd,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  void _pickImg() async {
    final imgPicker = ImagePicker();
    final img = await imgPicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      imageQuality: 70,
    );
    if (img != null) onAdd(File(img.path));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.md),
      child: Container(
        child: images.isEmpty
            ? Center(
                child: Column(
                children: const [
                  Icon(PhosphorIcons.imageSquare),
                  Gap.sm,
                  Text('Add Images (3 Max)')
                ],
              )).onTap(() => _pickImg())
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.map<Widget>((e) {
                  return Padding(
                    padding: const EdgeInsets.all(Insets.xs),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: Corners.smBorder,
                            child: Image.file(
                              e,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: -Insets.xs,
                          right: -Insets.sm,
                          child: Icon(
                            PhosphorIcons.xCircleFill,
                            color: AppColors.kError,
                          ).onTap(() => onRemove(images.indexOf(e))),
                        )
                      ],
                    ),
                  );
                }).toList()
                  ..addAll(
                    [
                      if (images.length != 3)
                        const SizedBox(
                          child: Padding(
                            padding: EdgeInsets.only(left: Insets.sm),
                            child: Icon(
                              PhosphorIcons.plusCircle,
                              size: IconSizes.lg,
                            ),
                          ),
                        ).onTap(() => _pickImg()),
                    ],
                  ),
              ),
      ),
    );
  }
}
