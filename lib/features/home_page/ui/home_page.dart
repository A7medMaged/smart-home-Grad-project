import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:smart_home_app/core/routing/routes.dart';
import 'package:smart_home_app/core/theming/colors.dart';
import 'package:smart_home_app/core/theming/text_style.dart';
import 'package:smart_home_app/core/widgets/app_text_button.dart';
import 'package:smart_home_app/core/widgets/home_control.dart';
import 'package:smart_home_app/features/home_page/widget/language_section.dart';
// import 'package:smart_home_app/features/home_page/widget/animated_drawer.dart';
// import 'package:smart_home_app/features/home_page/widget/custom_container.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String? _userName;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _userName = documentSnapshot.get('name');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Logger logger = Logger(printer: PrettyPrinter());
    return Scaffold(
      appBar: AppBar(
          title: FirebaseAuth.instance.currentUser!.emailVerified
              ? Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "welcome".tr(),
                          style: TextStyles.font18WhiteMedium,
                        ),
                        Text(
                          ", $_userName",
                          style: TextStyles.font18WhiteMedium,
                        ),
                      ],
                    ),
                    Gap(5.w),
                    const Icon(
                      Icons.verified,
                      color: mainBlue,
                    ),
                  ],
                )
              : AppTextButton(
                  buttonText: "Verify your e-mail",
                  textStyle: TextStyles.font16WhiteSemiBold,
                  onPressed: () {
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  }),
          systemOverlayStyle: SystemUiOverlayStyle.light),
      drawer: Drawer(
        backgroundColor: black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  // color: mainBlue,
                  ),
              child: Text(
                'smart-home'.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'profile'.tr(),
              ),
              onTap: () {
                // Handle the tap
              },
            ),
            LanguageSection(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'sign-out'.tr(),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                GoRouter.of(context).pushReplacement(AppRoutes.loginScreen);
                logger.f("User Logged Out");
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          spacing: 10.sp,
          children: [
            HomeControl(
              roomName: 'living-room'.tr(),
              icon: Icons.living_outlined,
              onTap: () => GoRouter.of(context).push(AppRoutes.devicesPage),
            ),
            HomeControl(
              roomName: 'bathroom'.tr(),
              icon: Icons.bathroom_outlined,
              onTap: () => GoRouter.of(context).push(AppRoutes.devicesPage),
            ),
          ],
        ),
      ),
    );
  }
}



// GridView(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 15,
//             mainAxisSpacing: 15,
//           ),
//           physics: const BouncingScrollPhysics(),
//           children: [
//             CustomContainer(
//               onTap: () => GoRouter.of(context).push(AppRoutes.devicesPage),
//               icon: Icons.bathtub_outlined,
//               title: "bathroom".tr(),
//             ),
//             CustomContainer(
//               onTap: () => GoRouter.of(context).push(AppRoutes.devicesPage),
//               icon: Icons.kitchen_outlined,
//               title: "kitchen".tr(),
//             ),
//             CustomContainer(
//               onTap: () => GoRouter.of(context).push(AppRoutes.devicesPage),
//               icon: Icons.living_outlined,
//               title: "living-room".tr(),
//             ),
//             CustomContainer(
//               onTap: () => GoRouter.of(context).push(AppRoutes.devicesPage),
//               icon: Icons.bed_outlined,
//               title: "bedroom".tr(),
//             ),
//           ],
//         ),