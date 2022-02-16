import 'package:dufuna/config/constants.dart';
import 'package:dufuna/config/theme.dart';
import 'package:dufuna/core/util/extension.dart';
import 'package:dufuna/core/widget/state.dart';
import 'package:dufuna/presentation/provider/property_provider.dart';
import 'package:dufuna/presentation/screen/home/filter.dart';
import 'package:dufuna/presentation/screen/home/property_item.dart';
import 'package:dufuna/presentation/screen/property/add_or_edit_property.dart';
import 'package:dufuna/presentation/screen/property/property_info.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final propertyProvider = context.watch<PropertyProvider>();
    final asyncValueOfProps = propertyProvider.asyncValueOfProps;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.kTitle,
          style: context.textTheme.subtitle1!.copyWith(
            color: AppColors.kDark,
            fontSize: FontSizes.s20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(const FilterPage()),
            icon: Icon(
              PhosphorIcons.funnel,
              color: AppColors.kDark,
            ),
          )
        ],
      ),
      body: asyncValueOfProps.when(
        loading: (msg) => Center(
            child: CircularProgressIndicator(
          color: AppColors.kPrimary,
        )),
        error: (err) => NoDataOrError(err!, variant: Variant.error),
        done: (props) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Insets.md, vertical: Insets.sm),
                child:
                    Text('${props.length} ${'Result'.pluralize(props.length)}'),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => PropertyItem(
                  props[index],
                  onTap: () => context.push(PropertyInfoPage(props[index])),
                ),
                itemCount: props.length,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(const AddOrEditPropertyPage(null)),
        child: const Icon(Icons.add),
        backgroundColor: AppColors.kPrimary,
      ),
    );
  }
}
