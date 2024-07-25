import 'dart:convert';
import 'package:get/get.dart';
import 'package:kushalplax/src/product_details/product_details_controller.dart';
import 'package:kushalplax/src/product_details/product_details_model.dart';
import '../../network/common_api_service.dart';

class ProductDetailsService {
  final ProductDetailsController productDetailsController =
      Get.find<ProductDetailsController>();

  Future<void> fetchProductDetails() async {
    try {
      final response = await CommonApiService()
          .productDetailsApi(productDetailsController.id.value.toString());
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // Convert JSON data to ProductDetailsModel
        final productDetails = ProductDetailsModel.fromJson(responseData);
        // Update the controller with the fetched data
        productDetailsController.productDetailsModel.value = productDetails;
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
