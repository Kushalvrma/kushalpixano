import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/color_constant.dart';
import '../../utils/theme.dart';


class SuccessDialog extends StatefulWidget {
  final String errorText;
  final Function onPressed;

  const SuccessDialog(
      {super.key, required this.errorText, required this.onPressed});

  @override
  State<SuccessDialog> createState() => _ErrorDialogState();

  static showErrorDialog(
      {String errorText = "Something Went Wrong",
        required Function onPressed}) {
    Get.dialog(

        SuccessDialog(
          errorText: errorText,
          onPressed: onPressed,
        ),
        barrierDismissible: false);
  }
}

class _ErrorDialogState extends State<SuccessDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 16.0), // Adjust as needed
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.all(0),
      elevation: 0,
      shadowColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 10, bottom: 10),
            child: Column(
              mainAxisSize:
              MainAxisSize.min, // Ensure the column takes minimum space
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      widget.onPressed();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 4.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Icon(
                  Icons.check,
                  color: IconColor.black,
                  size: 10.h,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Align(
                  // Align the text in the center
                  alignment: Alignment.center,
                  child: Text(
                    widget.errorText,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: appPrimaryTheme.textTheme.labelMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
