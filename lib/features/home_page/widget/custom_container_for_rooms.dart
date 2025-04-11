import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smart_home_app/core/theming/colors.dart';
import 'package:smart_home_app/core/theming/text_style.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class CustomContainerForRooms extends StatefulWidget {
  const CustomContainerForRooms(
      {super.key,
      required this.icon,
      required this.title,
      required this.icon1,
      required this.icon2});
  final IconData icon;
  final String title;
  final IconData icon1;
  final IconData icon2;

  @override
  State<CustomContainerForRooms> createState() =>
      _CustomContainerForRoomsState();
}

class _CustomContainerForRoomsState extends State<CustomContainerForRooms> {
  bool isSwitched = false;
  final _controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: white.withAlpha(50),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: 125,
      height: 125,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 50,
            color: mainBlue,
          ),
          Gap(15.h),
          Text(
            widget.title,
            style: TextStyles.font16BlueSemiBold,
          ),
          Gap(15.h),
          AdvancedSwitch(
            thumb: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                isSwitched ? widget.icon1 : widget.icon2,
                size: 20,
                color: Colors.white,
              ),
            ),
            height: 35,
            width: 70,
            controller: _controller,
            activeColor: mainBlue,
            inactiveColor: Colors.red,
            activeChild: Text(
              'ON',
              style: TextStyles.font16WhiteSemiBold,
            ),
            inactiveChild: Text(
              'OFF',
              style: TextStyles.font16WhiteSemiBold,
            ),
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
