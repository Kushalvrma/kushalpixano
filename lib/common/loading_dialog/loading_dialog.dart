import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';


class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            )));
  }

  static showProgressIndicatorAlertDialog() {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);
  }

  static removeProgressIndicatorAlertDialog() {
    Get.back();
  }
}
