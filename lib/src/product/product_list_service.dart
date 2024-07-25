import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../network/common_api_service.dart';
import 'product_list_controller.dart';
import 'product_list_model.dart';

class ProductCategoryListService {
  final ProductCategoryListController productCategoryListController = Get.put(ProductCategoryListController());

  Future<void> fetchProductCategories(int startIndex, int endIndex) async {
    try {
      final response = await CommonApiService().productListApi();
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        List<ProductCategoryListModel> allCategories = parseProductCategories(response.body);
        print('Parsed categories: $allCategories');
        // Add only the chunk of data needed
        productCategoryListController.addProductCategories(allCategories.sublist(startIndex, endIndex));
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  List<ProductCategoryListModel> parseProductCategories(String jsonString) {
    try {
      final List<dynamic> jsonData = jsonDecode(jsonString) as List<dynamic>;
      return jsonData.map((data) => ProductCategoryListModel.fromJson(data as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error parsing JSON: $e");
      return [];
    }
  }
}

