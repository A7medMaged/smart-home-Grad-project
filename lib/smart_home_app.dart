// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_app/core/routing/router.dart';
import 'package:smart_home_app/core/theming/colors.dart';
import 'package:logger/logger.dart';

class SmartHomeApp extends StatefulWidget {
  const SmartHomeApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  State<SmartHomeApp> createState() => _SmartHomeAppState();
}

class _SmartHomeAppState extends State<SmartHomeApp> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      child: MaterialApp.router(
        title: 'Smart Home App',
        routerConfig: AppRouter.router,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: mainBlue,
          scaffoldBackgroundColor: black,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
