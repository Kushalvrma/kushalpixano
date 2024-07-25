import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kushalplax/src/signup/signup_controller.dart';
import 'package:kushalplax/src/signup/signup_service.dart';
import 'package:sizer/sizer.dart';

import '../../utils/buttons.dart';
import '../../utils/color_constant.dart';
import '../../utils/theme.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: appPrimaryTheme.textTheme.labelMedium
              ?.copyWith(color: TextColor.blue, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: signupController.formKey,
            child: ListView(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              children: [
                _buildTextField('Email', signupController.emailController),
                _buildTextField('Username', signupController.usernameController),
                _buildTextField('Password', signupController.passwordController,
                    obscureText: true),
                _buildTextField(
                    'First Name', signupController.firstnameController),
                _buildTextField('Last Name', signupController.lastnameController),
                _buildTextField('City', signupController.cityController),
                _buildTextField('Street', signupController.streetController),
                _buildTextField('Number', signupController.numberController,
                    keyboardType: TextInputType.number),
                _buildTextField('Zipcode', signupController.zipcodeController),
                _buildTextField('Latitude', signupController.latController),
                _buildTextField('Longitude', signupController.longController),
                _buildTextField('Phone', signupController.phoneController),
                SizedBox(height: 2.h),
                PrimaryBlueButton(
                  onPressed: () {
                    if (signupController.formKey.currentState!.validate()) {
                      SignupService().signUpApi();
                    }
                  },
                  context: context,
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: TextColor.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: appPrimaryTheme.textTheme.displayLarge
              ?.copyWith(color: TextColor.blue, fontWeight: FontWeight.w400),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(),
          ),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
