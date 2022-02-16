import 'package:dufuna/config/constants.dart';
import 'package:dufuna/config/theme.dart';
import 'package:dufuna/core/util/extension.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool busy;
  final String msg;

  const LoadingOverlay(
      {required this.child, required this.busy, this.msg = "", Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          child,
          if (busy) ...[
            ModalBarrier(
                dismissible: false, color: Colors.black.withOpacity(0.5)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppColors.kPrimary,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Insets.sm),
                  child: Text(
                    msg,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ],
      ),
    );
  }
}
