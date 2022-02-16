import 'package:dufuna/core/util/extension.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback? onTap;
  final String? label;
  final double? width;
  final double? height;
  final Color? color;

  /// if child is not null, we want to use it instead of the label
  final Widget? child;
  const Button(this.label,
      {this.onTap, this.color, this.child, this.width, this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width,
      height: height ?? 49,
      child: ElevatedButton(
        onPressed: onTap,
        child: child ??
            Text(
              label!,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
        style: Theme.of(context)
            .elevatedButtonTheme
            .style!
            .copyWith(backgroundColor: MaterialStateProperty.all(color)),
      ),
    );
  }
}
