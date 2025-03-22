import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:smart_home_app/core/routing/router.dart';
import 'package:smart_home_app/firebase_options.dart';
import 'package:smart_home_app/smart_home_app.dart';

void main() async {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // ignore: unused_element
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        logger.f('User is currently signed out!');
      } else {
        logger.f('User is signed in!');
      }
    });
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      saveLocale: true,
      child: SmartHomeApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
