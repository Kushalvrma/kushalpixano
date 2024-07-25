import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kushalplax/page_routes/store_page_routes.dart';
import 'package:kushalplax/src/login/login_page.dart';
import 'package:kushalplax/utils/theme.dart';

import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const LoginPage(),
        theme: appPrimaryTheme,
        getPages: StorePageRoute.mainPageRoute,
      );
    });
  }
}
