import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../network/common_api_service.dart';
import '../../page_routes/page_route_constant.dart';
import '../../utils/preference_manager.dart';
import 'login_model.dart';
import 'login_service.dart';

class LoginController extends GetxController{

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String userName = '';
  String password = '';


  loginApi(){
    LoginService().loginApi();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    var userName= PreferenceManager.getString(PreferenceManager.userName);
    var password= PreferenceManager.getString(PreferenceManager.password);

    print("ssssssssss");
    print(userName);
    print(password);
    if(userName != "null" && password != "null"){
      final response = CommonApiService().loginAPI({
        "username": userName,
        "password": password,
      });
      response.then((value) async {
        if (value != null) {
          var decodedResponse = json.decode(value.body);

          var addEditContactResp = LoginModel.fromJson(decodedResponse);
          await PreferenceManager.setData(
              PreferenceManager.token, addEditContactResp.token);
          await PreferenceManager.setData(
              PreferenceManager.userName, userName);
          await PreferenceManager.setData(
              PreferenceManager.password, password);
          Get.toNamed(PageRouteConstant.productCategoryList);
        } else {
          Get.back();

        }
      }).catchError((error) {
        Get.back();

      });


    }
  }
}