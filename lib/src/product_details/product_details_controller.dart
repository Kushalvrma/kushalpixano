import 'package:get/get.dart';
import 'package:kushalplax/src/product_details/product_details_model.dart';
import 'package:kushalplax/src/product_details/product_details_service.dart';

class ProductDetailsController extends GetxController {
  RxInt id = 0.obs;

  Rx<ProductDetailsModel> productDetailsModel = ProductDetailsModel().obs;

  @override
  void onReady() {
    super.onReady();
    id.value = Get.arguments['id'];
    ProductDetailsService().fetchProductDetails();
  }
}
