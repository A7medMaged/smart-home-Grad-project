import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:smart_home_app/core/routing/routes.dart';
import 'package:smart_home_app/core/theming/colors.dart';
import 'package:smart_home_app/core/theming/text_style.dart';
import 'package:smart_home_app/core/widgets/home_control.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Logger logger = Logger(printer: PrettyPrinter());
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Welcome Back",
              style: TextStyles.font21WhiteMedium,
            ),
          ],
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/svgs/user-round.svg",
              colorFilter: const ColorFilter.mode(white, BlendMode.srcIn),
              width: 24,
            ),
            onPressed: () {
              GoRouter.of(context).push(AppRoutes.userProfile);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          spacing: 10.sp,
          children: [
            HomeControl(
              roomName: 'Living Room',
              icon: Icons.living_outlined,
              onTap: () => GoRouter.of(context).push(AppRoutes.devicesPage),
            ),
            HomeControl(
              roomName: 'Bathroom',
              icon: Icons.bathroom_outlined,
              onTap: () => GoRouter.of(context).push(AppRoutes.devicesPage),
            ),
          ],
        ),
      ),
    );
  }
}
