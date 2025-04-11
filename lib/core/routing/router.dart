import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home_app/core/repo/auth_repo.dart';
import 'package:smart_home_app/core/routing/routes.dart';
import 'package:smart_home_app/core/test/led_ui.dart';
import 'package:smart_home_app/features/home_page/ui/bedroom.dart';
import 'package:smart_home_app/features/home_page/ui/devices.dart';
import 'package:smart_home_app/features/home_page/ui/home_page.dart';
import 'package:smart_home_app/features/home_page/widget/user_profile.dart';
import 'package:smart_home_app/features/login/data/cubit/login_cubit.dart';
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
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(AuthRepo()),
          child: const LoginScreen(),
        ),
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
        path: AppRoutes.bedroom,
        builder: (context, state) => const Bedroom(),
      ),
      GoRoute(
        path: AppRoutes.devicesPage,
        builder: (context, state) => const DevicesPage(),
      ),
      GoRoute(
        path: AppRoutes.ledControlScreen,
        builder: (context, state) => const LedControlScreen(),
      ),
      GoRoute(
        path: AppRoutes.userProfile,
        builder: (context, state) => const UserProfileScreen(),
      ),
    ],
  );
}
