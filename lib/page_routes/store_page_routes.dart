import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:kushalplax/page_routes/page_route_constant.dart';

import '../src/login/login_page.dart';
import '../src/product/product_list_page.dart';
import '../src/product_details/product_details_page.dart';
import '../src/signup/signup_page.dart';

class StorePageRoute {
  static List<GetPage> mainPageRoute = [
    GetPage(name: PageRouteConstant.loginPage, page: () => const LoginPage()),
    GetPage(name: PageRouteConstant.productCategoryList, page: () => const ProductCategoryListPage()),
    GetPage(name: PageRouteConstant.signupPage, page: () => const SignupPage()),
    GetPage(name: PageRouteConstant.productDetailsPage, page: () => const ProductDetailsPage()),
  ];
}
