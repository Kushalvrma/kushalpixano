import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'color_constant.dart';

class PrimaryBlueButton extends ElevatedButton {
  PrimaryBlueButton({
    super.key,
    required Function() super.onPressed,
    required Widget super.child,
    required BuildContext context,
  }) : super(
          style: ElevatedButton.styleFrom(
            backgroundColor: BackgroundColor.blue,
            minimumSize: Size(80.w, 6.h),
          ),
        );
}
