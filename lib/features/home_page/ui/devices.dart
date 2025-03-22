import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_app/core/widgets/device_control.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DevicesPage> {
  bool isLightOn = false;
  bool isThermostatOn = false;
  bool isAirConditionerOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Smart Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          children: [
            DeviceControl(
              deviceName: 'light'.tr(),
              isOn: isLightOn,
              iconOff: Icons.lightbulb_outline,
              iconOn: Icons.lightbulb,
              onChanged: (value) {
                setState(() {
                  isLightOn = value;
                });
              },
            ),
            DeviceControl(
              deviceName: 'thermostat'.tr(),
              isOn: isThermostatOn,
              iconOff: Icons.thermostat_outlined,
              iconOn: Icons.thermostat,
              onChanged: (value) {
                setState(() {
                  isThermostatOn = value;
                });
              },
            ),
            DeviceControl(
              deviceName: 'air-conditioner'.tr(),
              isOn: isAirConditionerOn,
              iconOff: Icons.ac_unit_outlined,
              iconOn: Icons.ac_unit,
              onChanged: (value) {
                setState(() {
                  isAirConditionerOn = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
