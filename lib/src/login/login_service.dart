import 'dart:convert';

import 'package:get/get.dart';
import 'package:kushalplax/page_routes/page_route_constant.dart';
import 'package:kushalplax/utils/preference_manager.dart';

import '../../common/error_dialog/error_dialog.dart';
import '../../network/common_api_service.dart';
import 'login_controller.dart';
import 'login_model.dart';

class LoginService {
  final LoginController loginController = Get.put(LoginController());

  void loginApi() async {
    final response = CommonApiService().loginAPI({
      "username": loginController.emailController.text,
      "password": loginController.passwordController.text,
    });

    response.then((value) async {
      if (value != null) {
        var decodedResponse = json.decode(value.body);

        var addEditContactResp = LoginModel.fromJson(decodedResponse);
        await PreferenceManager.setData(
            PreferenceManager.token, addEditContactResp.token);
        await PreferenceManager.setData(
            PreferenceManager.userName, loginController.emailController.text);
        await PreferenceManager.setData(
            PreferenceManager.password, loginController.passwordController.text);
        Get.offAllNamed(PageRouteConstant.productCategoryList);
      } else {
        Get.dialog(ErrorDialog(
          errorText: "No response from server.",
          onPressed: () {
            Get.back();
          },
        ));
      }
    }).catchError((error) {
      print("Error: $error");
      Get.dialog(ErrorDialog(
        errorText: "An error occurred: $error",
        onPressed: () {
          Get.back();
        },
      ));
    });
  }
}
