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
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      logger.f('User is currently signed out!');
    } else {
      logger.f('User is signed in!');
    }
  });

  runApp(
    SmartHomeApp(
      appRouter: AppRouter(),
    ),
  );
}
