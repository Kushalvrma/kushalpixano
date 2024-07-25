import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kushalplax/utils/preference_manager.dart';
import 'package:sizer/sizer.dart';

import '../../common/error_dialog/error_dialog.dart';
import '../../network/common_api_service.dart';
import '../../page_routes/page_route_constant.dart';
import '../../utils/buttons.dart';
import '../../utils/color_constant.dart';
import '../../utils/theme.dart';
import 'login_controller.dart';
import 'login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());

  bool passwordVisible = false;
  String userName = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BackgroundColor.white,
        automaticallyImplyLeading: false, // This removes the back icon
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: loginController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hi! Welcome!",
                  style: appPrimaryTheme.textTheme.titleLarge
                      ?.copyWith(color: TextColor.blue),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Login",
                  style: appPrimaryTheme.textTheme.titleSmall
                      ?.copyWith(color: TextColor.blue),
                ),
                SizedBox(
                  height: 4.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                  style: appPrimaryTheme.textTheme.displayLarge?.copyWith(
                      color: TextColor.blue, fontWeight: FontWeight.w400),
                  controller: loginController.emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      size: 20,
                    ),
                    hintText: 'Username',
                    hintStyle: appPrimaryTheme.textTheme.displayLarge?.copyWith(
                        color: TextColor.grey, fontWeight: FontWeight.w400),
                    fillColor: Colors.green,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  obscureText: passwordVisible,
                  controller: loginController.passwordController,
                  style: appPrimaryTheme.textTheme.displayLarge?.copyWith(
                      color: TextColor.blue, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    hintStyle: appPrimaryTheme.textTheme.displayLarge?.copyWith(
                        color: TextColor.grey, fontWeight: FontWeight.w400),
                    fillColor: Colors.green,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forgot Password?",
                    style: appPrimaryTheme.textTheme.displayLarge
                        ?.copyWith(color: TextColor.lightBlue),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Center(
                  child: PrimaryBlueButton(
                    onPressed: () {
                        if (loginController.formKey.currentState!.validate()) {
                          loginController.loginApi();
                        }
                    },
                    context: context,
                    child: Text(
                      "Sign In",
                      style: appPrimaryTheme.textTheme.headlineLarge
                          ?.copyWith(color: TextColor.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Center(
                  child: Text(
                    "Or with email",
                    style: appPrimaryTheme.textTheme.displayLarge
                        ?.copyWith(color: TextColor.lightGrey),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 40.w,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: BorderColor.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.apple),
                              Text(
                                "Apple",
                                style: appPrimaryTheme.textTheme.displayLarge
                                    ?.copyWith(
                                        color: TextColor.darkBlack,
                                        fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: BorderColor.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.apple),
                              Text(
                                "Google",
                                style: appPrimaryTheme.textTheme.displayLarge
                                    ?.copyWith(
                                        color: TextColor.darkBlack,
                                        fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(PageRouteConstant.signupPage);
                  },
                  child: Center(
                    child: RichText(
                      text: new TextSpan(
                        text: "Don't have not account?",
                        style: appPrimaryTheme.textTheme.headlineSmall?.copyWith(
                            color: TextColor.darkBlack,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          new TextSpan(
                            text: ' Sign Up',
                            style: appPrimaryTheme.textTheme.headlineSmall
                                ?.copyWith(
                                    color: TextColor.blue,
                                    fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
