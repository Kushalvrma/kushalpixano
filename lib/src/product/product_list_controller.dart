import 'package:get/get.dart';
import 'package:kushalplax/src/product/product_list_service.dart';

import 'product_list_model.dart';

class ProductCategoryListController extends GetxController {
  RxList<ProductCategoryListModel> productCategoryListModel = <ProductCategoryListModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;
  final int chunkSize = 10; // Number of items per chunk
  int currentStartIndex = 0;
  int currentEndIndex = 10;

  @override
  void onReady() {
    super.onReady();
    fetchMoreProducts();
  }

  Future<void> fetchMoreProducts() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    try {
      await ProductCategoryListService().fetchProductCategories(currentStartIndex, currentEndIndex);
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void addProductCategories(List<ProductCategoryListModel> newProducts) {
    if (newProducts.isEmpty) {
      hasMore.value = false;
    } else {
      productCategoryListModel.addAll(newProducts);
      currentStartIndex = currentEndIndex;
      currentEndIndex += chunkSize;
    }
  }
}
