import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/core/test/cubit/led_cubit.dart';
import 'package:smart_home_app/core/theming/colors.dart';

class DeviceControl extends StatelessWidget {
  final bool isOn;
  final IconData iconOn;
  final IconData iconOff;
  final String deviceName;
  final ValueChanged<bool> onChanged;

  const DeviceControl({
    super.key,
    required this.isOn,
    required this.iconOn,
    required this.iconOff,
    required this.deviceName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: isOn ? Colors.green : Colors.white,
      shadowColor: isOn ? Colors.green : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          Icon(
            isOn ? iconOn : iconOff,
            color: isOn ? Colors.black : Colors.grey[600],
          ),
          Text(
            deviceName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: isOn ? Colors.black : Colors.grey[600],
            ),
          ),
          ElevatedButton(
            onPressed: () => context.read<LedCubit>().toggleLed(),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                isOn ? Colors.green : Colors.red,
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: Text(
              isOn ? 'On' : 'Off',
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
