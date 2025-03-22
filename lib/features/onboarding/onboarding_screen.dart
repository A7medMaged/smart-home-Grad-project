import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home_app/core/routing/routes.dart';
import 'package:smart_home_app/core/theming/text_style.dart';
import 'package:smart_home_app/core/widgets/app_text_button.dart';
import 'package:smart_home_app/features/onboarding/widgets/image_and_text.dart';
import 'package:smart_home_app/features/onboarding/widgets/logo_and_name.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(
          top: 30.h,
          left: 20.w,
          right: 20.w,
          bottom: 30.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoAndName(),
            Gap(30.h),
            const ImageAndText(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Text(
                    'Manage your home easily with Smart Home to get a new experience',
                    textAlign: TextAlign.center,
                    style: TextStyles.font13GrayRegular,
                  ),
                  Gap(30.h),
                  Image.asset('assets/images/smart-house.png'),
                  Gap(60.h),
                  AppTextButton(
                    buttonText: "Get Started",
                    textStyle: TextStyles.font16WhiteSemiBold,
                    onPressed: () {
                      GoRouter.of(context).pushNamed(AppRoutes.loginScreen);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
