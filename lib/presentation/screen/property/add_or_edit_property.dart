import 'dart:io';
import 'package:dufuna/config/constants.dart';
import 'package:dufuna/config/theme.dart';
import 'package:dufuna/core/model/property.dart';
import 'package:dufuna/core/util/async_value.dart';
import 'package:dufuna/core/util/date_formatter.dart';
import 'package:dufuna/core/util/extension.dart';
import 'package:dufuna/core/util/input_validator.dart';
import 'package:dufuna/core/widget/back_button.dart';
import 'package:dufuna/core/widget/button.dart';
import 'package:dufuna/core/widget/custom_selection_fields.dart';
import 'package:dufuna/core/widget/gap.dart';
import 'package:dufuna/core/widget/overlay.dart';
import 'package:dufuna/core/widget/text_input.dart';
import 'package:dufuna/presentation/provider/property_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOrEditPropertyPage extends StatefulWidget {
  final Property? property;
  const AddOrEditPropertyPage(this.property, {Key? key}) : super(key: key);

  @override
  _AddOrEditPropertyPageState createState() => _AddOrEditPropertyPageState();
}

class _AddOrEditPropertyPageState extends State<AddOrEditPropertyPage> {
  final formKey = GlobalKey<FormState>();
  final DateFormatter dateFormatter = DateFormatter('yyyy-MM-dd');
  bool formIsDirty = false;
  List<File> images = [];
  late Property prop;
  late String type;
  late int numOfToilet;
  late int numOfSittingroom;
  late int numOfBedroom;
  late int numOfKitchen;
  late int numOfBathroom;
  late DateTime validFrom, validTo;

  @override
  void initState() {
    prop = widget.property ?? Property.seed();
    type = widget.property?.type ?? types.first;
    numOfSittingroom = widget.property?.toilet ?? numOfSittingrooms.first;
    numOfToilet = widget.property?.toilet ?? numOfToilets.first;
    numOfBedroom = widget.property?.toilet ?? numOfBedrooms.first;
    numOfKitchen = widget.property?.toilet ?? numOfKitchens.first;
    numOfBathroom = widget.property?.toilet ?? numOfBathrooms.first;
    validFrom = widget.property?.validFrom.toDateTime() ?? DateTime.now();
    validTo = widget.property?.validTo.toDateTime() ??
        validFrom.add(const Duration(days: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.property != null;
    final uploading = context.watch<PropertyProvider>().asyncValueOfUpload;
    return LoadingOverlay(
      busy: uploading?.status != null &&
          uploading?.status == AsyncValueStatus.loading,
      msg: uploading?.message ?? '',
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isEdit ? 'Edit Property' : 'Add New Property',
            style: context.textTheme.subtitle1!.copyWith(
              color: AppColors.kDark,
            ),
          ),
          leading: const Padding(
            padding: EdgeInsets.fromLTRB(Insets.md, 10, 2, 10),
            child: Backbtn(),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap.md,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.md),
                  child: InputTextField(
                    onSaved: (value) => prop = prop.copyWith(owner: value),
                    initialValue: prop.owner,
                    labelText: 'Owner',
                    hintText: 'Property owner full name',
                  ),
                ),
                Gap.md,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.md),
                  child: InputTextField(
                    onSaved: (value) => prop = prop.copyWith(desc: value),
                    initialValue: prop.desc,
                    labelText: 'Description',
                    hintText: 'Property description',
                  ),
                ),
                Gap.md,
                if (!isEdit)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Insets.md),
                    child: InputTextField(
                      onSaved: (value) => prop = prop.copyWith(address: value),
                      initialValue: prop.address,
                      labelText: 'Address',
                      hintText: 'Property address',
                    ),
                  ),
                Gap.md,
                InputSelectionField<String>('Property Type',
                    items: types, groupValue: type, onChanged: (value) {
                  setState(() {
                    type = value;
                  });
                }),
                Gap.md,
                InputSelectionField<int>('Number Of Sittingroom',
                    items: numOfSittingrooms,
                    groupValue: numOfSittingroom, onChanged: (value) {
                  setState(() {
                    numOfSittingroom = value;
                  });
                }),
                Gap.md,
                InputSelectionField<int>('Number Of Bedroom',
                    items: numOfBedrooms,
                    groupValue: numOfBedroom, onChanged: (value) {
                  setState(() {
                    numOfBedroom = value;
                  });
                }),
                Gap.md,
                InputSelectionField<int>('Number Of Bathroom',
                    items: numOfBathrooms,
                    groupValue: numOfBathroom, onChanged: (value) {
                  setState(() {
                    numOfBathroom = value;
                  });
                }),
                Gap.md,
                InputSelectionField<int>('Number Of Toilet',
                    items: numOfToilets,
                    groupValue: numOfToilet, onChanged: (value) {
                  setState(() {
                    numOfToilet = value;
                  });
                }),
                Gap.md,
                InputSelectionField<int>('Number Of Kitchen',
                    items: numOfKitchens,
                    groupValue: numOfKitchen, onChanged: (value) {
                  setState(() {
                    numOfKitchen = value;
                  });
                }),
                Gap.md,
                if (!isEdit) ...[
                  DateSelectionField('Valid from',
                      value: validFrom,
                      onChanged: (value) => {
                            if (value != validFrom)
                              {
                                setState(() {
                                  validFrom = value;
                                })
                              }
                          }),
                  Gap.md,
                ],
                DateSelectionField('Valid to',
                    value: validTo,
                    onChanged: (value) => {
                          if (value != validTo)
                            {
                              setState(() {
                                validTo = value;
                              })
                            }
                        }),
                Gap.md,
                if (!isEdit) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Insets.md),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Images (${images.length}/3)',
                        style: context.textTheme.bodyLarge!
                            .copyWith(color: AppColors.kDark),
                      ),
                    ),
                  ),
                  Gap.md,
                  ImageSelectionField(
                    images,
                    onAdd: (image) {
                      setState(() {
                        images.add(image);
                      });
                    },
                    onRemove: (index) {
                      setState(() {
                        images.removeAt(index);
                      });
                    },
                  ),
                ],
                if (formIsDirty) ...[
                  Gap.md,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Insets.md),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Some fields are invalid',
                        style: context.textTheme.bodyLarge!
                            .copyWith(color: AppColors.kError),
                      ),
                    ),
                  ),
                ],
                Gap.lg,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.md),
                  child: Button(
                    isEdit ? 'EDIT PROPERTY' : 'ADD PROPERTY',
                    onTap: () {
                      final failureOrValid = InputUtils.validateForm(formKey);
                      failureOrValid.fold((failure) {
                        setState(() {
                          formIsDirty = true;
                        });
                      }, (_) async {
                        if (images.isEmpty && !isEdit) {
                          context.showSnack(
                            'Add atleast one image of this property',
                          );
                        } else if (validTo.isBefore(validFrom) ||
                            validFrom.difference(DateTime.now()).inDays == 0) {
                          context.showSnack(
                            '"Valid from" date must be greater than today and "Valid to" date must be greater than "Valid from"',
                          );
                        } else {
                          setState(() {
                            formIsDirty = false;
                          });
                          final failureOrSuccess = await context
                              .read<PropertyProvider>()
                              .uploadProp(
                                prop.copyWith(
                                  type: type,
                                  sittingRoom: numOfSittingroom,
                                  bedRoom: numOfBedroom,
                                  bathRoom: numOfBathroom,
                                  kitchen: numOfKitchen,
                                  toilet: numOfToilet,
                                  validFrom:
                                      dateFormatter.datetimeToString(validFrom),
                                  validTo:
                                      dateFormatter.datetimeToString(validTo),
                                ),
                                isEdit,
                                images,
                              );

                          failureOrSuccess.fold(
                              (failure) => context.showSnack(
                                    failure,
                                    AppColors.kError,
                                  ), (_) {
                            context.showSnack(
                              isEdit
                                  ? 'Property updated successfully'
                                  : 'Property listed successfully',
                              AppColors.kPrimary,
                            );

                            context.pop();
                          });
                        }
                      });
                    },
                  ),
                ),
                const Gap(70)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
