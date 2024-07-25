import 'package:http/http.dart' as http;
import 'api_endpoints.dart';
import 'http_client.dart';

class CommonApiService {
  CommonApiService._privateConstructor();

  static final CommonApiService _apiServiceInstance = CommonApiService._privateConstructor();

  factory CommonApiService() {
    return _apiServiceInstance;
  }

  final HttpClient _httpClient = HttpClient();

  Future<http.Response> loginAPI(Map<dynamic, dynamic> loginAPIBody) async {
    return _httpClient.postRequest(ApiEndpoints.login, body: loginAPIBody);
  }

  Future<http.Response> signupAPI(Map<dynamic, dynamic> loginAPIBody) async {
    return _httpClient.postRequest(ApiEndpoints.signup, body: loginAPIBody);
  }

  Future<http.Response> productListApi() async {
    return _httpClient.getRequest(ApiEndpoints.products);
  }

  Future<http.Response> productDetailsApi(id) async {
    return _httpClient.getRequest(ApiEndpoints.productDetails.replaceAll("id", id));
  }



}
