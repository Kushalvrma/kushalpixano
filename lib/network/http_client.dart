import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';

import '../common/error_dialog/error_dialog.dart';
import '../common/loading_dialog/loading_dialog.dart';
import '../utils/preference_manager.dart';
import '../utils/utils.dart';
import 'api_endpoints.dart';

class HttpClient {
  HttpClient._privateConstructor();

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  static Map<String, String> getHeaders() {
    var token = PreferenceManager.getString(PreferenceManager.token);
    var header = <String, String>{
      "Authorization": "Bearer $token",
      "Accept": "application/json",
      "content-type": "application/json",
    };
    print(header);
    return header;
  }

  Future<Response> getRequest(String path) async {
    LoadingDialog.showProgressIndicatorAlertDialog();
    Response response = await get(
      Uri.parse(ApiEndpoints.baseUrl + path),
      headers: getHeaders(),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        LoadingDialog.removeProgressIndicatorAlertDialog();
        ErrorDialog.showErrorDialog(
            errorText: "Something went wrong,Please try again.",
            onPressed: () {
              Get.back();
            });
        throw TimeoutException('Can\'t connect in 30 seconds.');
      },
    );
    print(ApiEndpoints.baseUrl + path);
    LoadingDialog.removeProgressIndicatorAlertDialog();
    prettyPrintJson(response.body);

    try {
      var decode = json.decode(response.body);
      if (decode is Map<String, dynamic>) {
        switch (decode['statusCode']) {
          case 500:
            {
              ErrorDialog.showErrorDialog(
                  errorText: decode['message'],
                  onPressed: () {
                    Get.back();
                  });
            }
            break;
        }
      }
    } catch (e) {
      print("Error decoding JSON: $e");
    }

    return response;
  }

  Future<Response> deleteRequest(String path) async {
    LoadingDialog.showProgressIndicatorAlertDialog();
    Response response = await delete(
      Uri.parse(ApiEndpoints.baseUrl + path),
      headers: getHeaders(),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        LoadingDialog.removeProgressIndicatorAlertDialog();
        ErrorDialog.showErrorDialog(
            errorText: "Something went wrong,Please try again.",
            onPressed: () {
              Get.back();
            });
        throw TimeoutException('Can\'t connect in 30 seconds.');
      },
    );
    print(ApiEndpoints.baseUrl + path);
    LoadingDialog.removeProgressIndicatorAlertDialog();
    prettyPrintJson(response.body);

    switch (response.statusCode) {
      case 500:
        {
          ErrorDialog.showErrorDialog(onPressed: () {
            Get.back();
          });
        }
        break;

      case 401:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Your Session is Expired, You Need to Login Again. ",
              onPressed: () {
                // Get.offAllNamed(PageRouteConstants.loginPage);
              });
        }
        break;

      case 200:
        var decode = json.decode(response.body);
        switch (decode['statusCode']) {
          case 500:
            {
              ErrorDialog.showErrorDialog(
                  errorText: decode['message'],
                  onPressed: () {
                    Get.back();
                  });
            }
            break;
        }
    }
    return response;
  }

  Future<Response> postRequest(String path, {Map<dynamic, dynamic>? body}) async {
    try {
      LoadingDialog.showProgressIndicatorAlertDialog();

      print(ApiEndpoints.baseUrl + path);
      // print(getHeaders());
      prettyPrintMap(body);

      Response response = await post(
        Uri.parse(ApiEndpoints.baseUrl + path),
        body: jsonEncode(body),
        headers: getHeaders(),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          LoadingDialog.removeProgressIndicatorAlertDialog();
          ErrorDialog.showErrorDialog(
              errorText: "Something went wrong,Please try again.",
              onPressed: () {
                Get.back();
              });
          throw TimeoutException('Can\'t connect in 30 seconds.');
        },
      );
      LoadingDialog.removeProgressIndicatorAlertDialog();

      switch (response.statusCode) {
        case 500:
          {
            ErrorDialog.showErrorDialog(onPressed: () {
              Get.back();
            });
          }
          break;
        case 401:
          {
            ErrorDialog.showErrorDialog(
                errorText: "Your Session is Expired, You Need to Login Again. ",
                onPressed: () {
                  // Get.offAllNamed(PageRouteConstants.loginPage);
                });
          }
          break;

        case 400:
          {}
          break;

        case 200:
          var decode = json.decode(response.body);
          switch (decode['statusCode']) {
            case 500:
              {
                ErrorDialog.showErrorDialog(
                    errorText: decode['message'],
                    onPressed: () {
                      Get.back();
                    });
              }
              break;
          }
      }

      prettyPrintMap(response.headers);
      prettyPrintJson(response.body);
      return response;
    } catch (e) {
      LoadingDialog.removeProgressIndicatorAlertDialog();
      rethrow;
    }
  }
  Future<Response> putRequest(String path, {Map<dynamic, dynamic>? body}) async {
    LoadingDialog.showProgressIndicatorAlertDialog();

    print(ApiEndpoints.baseUrl + path);
    // print(getHeaders());
    prettyPrintMap(body);

    Response response = await put(
      Uri.parse(ApiEndpoints.baseUrl + path),
      body: jsonEncode(body),
      headers: getHeaders(),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        LoadingDialog.removeProgressIndicatorAlertDialog();
        ErrorDialog.showErrorDialog(
            errorText: "Something went wrong,Please try again.",
            onPressed: () {
              Get.back();
            });
        throw TimeoutException('Can\'t connect in 30 seconds.');
      },
    );

    LoadingDialog.removeProgressIndicatorAlertDialog();

    switch (response.statusCode) {
      case 500:
        {
          ErrorDialog.showErrorDialog(onPressed: () {
            Get.back();
          });
        }
        break;

      case 401:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Your Session is Expired, You Need to Login Again. ",
              onPressed: () {
                // Get.offAllNamed(PageRouteConstants.loginPage);
              });
        }
        break;

      case 400:
        {}
        break;

      case 200:
        var decode = json.decode(response.body);
        switch (decode['statusCode']) {
          case 500:
            {
              ErrorDialog.showErrorDialog(
                  errorText: decode['message'],
                  onPressed: () {
                    Get.back();
                  });
            }
            break;
        }
    }

    prettyPrintMap(response.headers);
    prettyPrintJson(response.body);
    return response;
  }

  Future<Response> postRequestArray(String path, {required List<Object> body}) async {
    LoadingDialog.showProgressIndicatorAlertDialog();

    print(ApiEndpoints.baseUrl + path);
    print(json.encode(body));

    Response response;
    response = await post(
      Uri.parse(ApiEndpoints.baseUrl + path),
      body: json.encode(body),
      headers: getHeaders(),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        LoadingDialog.removeProgressIndicatorAlertDialog();
        ErrorDialog.showErrorDialog(
            errorText: "Something went wrong,Please try again.",
            onPressed: () {
              Get.back();
            });
        throw TimeoutException('Can\'t connect in 30 seconds.');
      },
    );
    LoadingDialog.removeProgressIndicatorAlertDialog();

    switch (response.statusCode) {
      case 500:
        {
          ErrorDialog.showErrorDialog(onPressed: () {
            Get.back();
          });
        }
        break;

      case 401:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Your Session is Expired, You Need to Login Again. ",
              onPressed: () {
                // Get.offAllNamed(PageRouteConstants.loginPage);
              });
        }
        break;

      case 200:
        var decode = json.decode(response.body);
        switch (decode['statusCode']) {
          case 500:
            {
              ErrorDialog.showErrorDialog(
                  errorText: decode['message'],
                  onPressed: () {
                    Get.back();
                  });
            }
            break;
        }
    }

    prettyPrintMap(response.headers);
    prettyPrintJson(response.body);
    return response;
  }

  Future<Response> patchRequest(String path, {Map<dynamic, dynamic>? body}) async {
    LoadingDialog.showProgressIndicatorAlertDialog();

    print(ApiEndpoints.baseUrl + path);
    // print(getHeaders());
    prettyPrintMap(body);

    Response response;
    response = await patch(
      Uri.parse(ApiEndpoints.baseUrl + path),
      body: jsonEncode(body),
      headers: getHeaders(),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        LoadingDialog.removeProgressIndicatorAlertDialog();
        ErrorDialog.showErrorDialog(
            errorText: "Something went wrong,Please try again.",
            onPressed: () {
              Get.back();
            });
        throw TimeoutException('Can\'t connect in 30 seconds.');
      },
    );
    LoadingDialog.removeProgressIndicatorAlertDialog();

    switch (response.statusCode) {
      case 500:
        {
          ErrorDialog.showErrorDialog(onPressed: () {
            Get.back();
          });
        }
        break;

      case 401:
        {
          ErrorDialog.showErrorDialog(
              errorText: "Your Session is Expired, You Need to Login Again. ",
              onPressed: () {
                // Get.offAllNamed(PageRouteConstants.loginPage);
              });
        }
        break;

      case 400:
        {}
        break;

      case 200:
        var decode = json.decode(response.body);
        switch (decode['statusCode']) {
          case 500:
            {
              ErrorDialog.showErrorDialog(
                  errorText: decode['message'],
                  onPressed: () {
                    Get.back();
                  });
            }
            break;
        }
    }

    prettyPrintMap(response.headers);
    prettyPrintJson(response.body);
    return response;
  }
}
