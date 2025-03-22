import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_home_app/features/home_page/widget/custom_container_for_rooms.dart';

class Bathroom extends StatefulWidget {
  const Bathroom({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BathroomState createState() => _BathroomState();
}

class _BathroomState extends State<Bathroom> {
  @override
  Widget build(BuildContext c) {
    // double w = MediaQuery.of(context).size.width;
    // int columnCount = 3;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            'bathroom'.tr(),
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
            CustomContainerForRooms(
              icon: Icons.heat_pump,
              title: 'heat-pump'.tr(),
              icon1: Icons.heat_pump,
              icon2: Icons.heat_pump_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
