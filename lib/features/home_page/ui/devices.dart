import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/core/test/cubit/led_cubit.dart';
import 'package:smart_home_app/core/test/led_repo.dart';
import 'package:smart_home_app/core/widgets/device_control.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DevicesPage> {
  // bool isLightOn = false;
  // bool isThermostatOn = false;
  // bool isAirConditionerOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Smart Home'),
      ),
      body: BlocProvider(
        create: (context) => LedCubit(LedRepository()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            children: [
              BlocBuilder<LedCubit, bool>(
                builder: (context, state) {
                  return DeviceControl(
                    deviceName: 'Led',
                    isOn: state,
                    iconOff: Icons.lightbulb_outline,
                    iconOn: Icons.lightbulb,
                    onChanged: (value) {
                      setState(() {
                        state = value;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
