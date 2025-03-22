import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home_app/core/routing/routes.dart';
import 'package:smart_home_app/features/home_page/ui/bathroom.dart';
import 'package:smart_home_app/features/home_page/ui/bedroom.dart';
import 'package:smart_home_app/features/home_page/ui/devices.dart';
import 'package:smart_home_app/features/home_page/ui/kitchen.dart';
import 'package:smart_home_app/features/home_page/ui/livingroom.dart';
import 'package:smart_home_app/features/home_page/ui/home_page.dart';
import 'package:smart_home_app/features/home_page/ui/test.dart';
import 'package:smart_home_app/features/login/ui/login_screen.dart';
import 'package:smart_home_app/features/onboarding/onboarding_screen.dart';
import 'package:smart_home_app/features/signup/ui/signup_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: (FirebaseAuth.instance.currentUser != null &&
            FirebaseAuth.instance.currentUser!.emailVerified)
        ? AppRoutes.homePageScreen
        : AppRoutes.loginScreen,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.homePageScreen,
        builder: (context, state) => const HomePageScreen(),
      ),
      GoRoute(
        path: AppRoutes.livingRoom,
        builder: (context, state) => const LivingRoom(),
      ),
      GoRoute(
        path: AppRoutes.kitchen,
        builder: (context, state) => const Kitchen(),
      ),
      GoRoute(
        path: AppRoutes.bedroom,
        builder: (context, state) => const Bedroom(),
      ),
      GoRoute(
        path: AppRoutes.bathroom,
        builder: (context, state) => const Bathroom(),
      ),
      GoRoute(
        path: AppRoutes.devicesPage,
        builder: (context, state) => const DevicesPage(),
      ),
      GoRoute(
        path: AppRoutes.homePageScreenTwo,
        builder: (context, state) => const HomePageScreenTwo(),
      ),
    ],
  );
}
