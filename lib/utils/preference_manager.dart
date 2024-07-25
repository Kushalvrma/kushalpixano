import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static const String token = "token";
  static const String userName = "userName";
  static const String password = "password";


  static setData(String key, dynamic value) async {
    getStorage().write(key, value);
  }

  static String? getString(String key) {
    return "${getStorage().read(key)}";
  }

  static GetStorage getStorage() {
    return GetStorage();
  }

  static deleteData() async {
    getStorage().erase();
  }
}


// import 'package:get_storage/get_storage.dart';
// import '../src/auth/login/model/login_model.dart'; // Import the login model to access the LoginData class
//
// class PreferenceManager {
//   static const String token = "token";
//   static const String loginDataKey = "loginData"; // Define a key for login data
//
//   static setData(String key, dynamic value) async {
//     final box = await getStorage();
//     box.write(key, value);
//   }
//
//   static dynamic getData(String key) async {
//     final box = await getStorage();
//     return box.read(key);
//   }
//
//   static Future<void> saveLoginData(LoginData loginData) async {
//     final loginDataJson = loginData.toJson(); // Serialize loginData to JSON
//     await setData(loginDataKey, loginDataJson);
//   }
//
//   static Future<LoginData?> getLoginData() async {
//     final loginDataJson = await getData(loginDataKey);
//     if (loginDataJson != null) {
//       return LoginData.fromJson(loginDataJson); // Deserialize JSON to LoginData object
//     }
//     return null;
//   }
//
//   // Generic method to get any property from the stored LoginData object
//   static Future<T?> getValueFromLoginData<T>(T Function(LoginData) selector) async {
//     final loginData = await getLoginData();
//     if (loginData != null) {
//       return selector(loginData);
//     }
//     return null;
//   }
//
//   static GetStorage getStorage() {
//     return GetStorage();
//   }
//
//   static deleteData() async {
//     final box = await getStorage();
//     box.erase();
//   }
// }


