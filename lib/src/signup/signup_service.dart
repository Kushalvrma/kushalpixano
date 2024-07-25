import 'dart:convert';

import 'package:get/get.dart';
import 'package:kushalplax/page_routes/page_route_constant.dart';
import 'package:kushalplax/src/signup/signup_controller.dart';

import '../../common/error_dialog/error_dialog.dart';
import '../../common/error_dialog/success_dialog.dart';
import '../../network/common_api_service.dart';
import '../login/login_model.dart';

class SignupService {
  final SignupController signupController = Get.put(SignupController());

  void signUpApi() async {
    try {
      final response = await CommonApiService().signupAPI({
        "email": signupController.emailController.text,
        "username": signupController.usernameController.text,
        "password": signupController.passwordController.text,
        "name": {
          "firstname": signupController.firstnameController.text,
          "lastname": signupController.lastnameController.text
        },
        "address": {
          "city": signupController.cityController.text,
          "street": signupController.streetController.text,
          "number": signupController.numberController.text,
          "zipcode": signupController.zipcodeController.text,
          "geolocation": {
            "lat": signupController.latController.text,
            "long": signupController.longController.text
          }
        },
        "phone": signupController.phoneController.text
      });

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        print('Response: $decodedResponse');
        print('Response: ${response.statusCode}');
        Get.dialog(
          SuccessDialog(
            errorText: "User Successfully Added",
            onPressed: () {
              Get.toNamed(PageRouteConstant.loginPage);
            },
          ),
        );
      } else {
        print('Error: ${response.statusCode}');
        Get.dialog(
          ErrorDialog(
            errorText: "Error: ${response.statusCode}",
            onPressed: () {
              Get.back();
            },
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      Get.dialog(
        ErrorDialog(
          errorText: "An error occurred: $e",
          onPressed: () {
            Get.back();
          },
        ),
      );
    }
  }
}
