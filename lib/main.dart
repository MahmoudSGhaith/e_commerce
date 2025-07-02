import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routes_manager/route_generator.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await StorageServices.getToken();
  runApp( MainApp(token: token,));
}

class MainApp extends StatelessWidget {
  String? token;
  MainApp({super.key , this.token});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: child,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: token == null ?Routes.signInRoute : Routes.mainRoute,
      ),
    );
  }
}
