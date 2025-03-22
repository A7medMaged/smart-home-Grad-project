import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_app/features/home_page/widget/custom_container_for_rooms.dart';

class Kitchen extends StatefulWidget {
  const Kitchen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KitchenState createState() => _KitchenState();
}

class _KitchenState extends State<Kitchen> {
  @override
  Widget build(BuildContext c) {
    // double w = MediaQuery.of(context).size.width;
    // int columnCount = 3;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'kitchen'.tr(),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            CustomContainerForRooms(
              icon: Icons.lightbulb_sharp,
              title: 'light'.tr(),
              icon1: Icons.lightbulb,
              icon2: Icons.lightbulb_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
