import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home_app/core/routing/routes.dart';
import 'package:smart_home_app/core/theming/text_style.dart';

class BackToLoginScreen extends StatelessWidget {
  const BackToLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account',
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(
            text: ' ',
            style: TextStyles.font13LightGrayRegular,
          ),
          TextSpan(
            text: 'Sign in',
            style: TextStyles.font13BlueSemiBold,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                GoRouter.of(context).pushReplacement(AppRoutes.loginScreen);
              },
          ),
        ],
      ),
    );
  }
}
