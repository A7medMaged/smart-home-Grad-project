import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home_app/core/routing/routes.dart' show AppRoutes;
import 'package:smart_home_app/core/theming/colors.dart';
import 'package:smart_home_app/core/theming/text_style.dart';
import 'package:smart_home_app/core/widgets/app_text_button.dart';

class SignoutSection extends StatelessWidget {
  const SignoutSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        onTap: () {
          showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Sign Out"),
                  content: Text("Are you sure you want to sign out?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "No",
                        style: const TextStyle(color: white),
                      ),
                    ),
                    SizedBox(
                      width: 80.w,
                      child: AppTextButton(
                        buttonText: 'Yes',
                        textStyle: TextStyle(
                          color: white,
                        ),
                        backgroundColor: red,
                        onPressed: () async {
                          GoRouter.of(context)
                              .pushReplacement(AppRoutes.loginScreen);
                        },
                      ),
                    ),
                  ],
                );
              });
        },
        title: Text(
          "Sign Out",
          style: TextStyles.font21WhiteMedium,
        ),
        trailing: Icon(Icons.logout, color: red),
      ),
    );
  }
}
