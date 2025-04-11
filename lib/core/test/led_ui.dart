import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/core/test/cubit/led_cubit.dart';
import 'package:smart_home_app/core/test/led_repo.dart';

class LedControlScreen extends StatelessWidget {
  const LedControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LED Control')),
      body: BlocProvider(
        create: (context) => LedCubit(LedRepository()),
        child: Center(
          child: BlocBuilder<LedCubit, bool>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lightbulb,
                    size: 100,
                    color: state ? Colors.yellow : Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state ? 'ON' : 'OFF',
                    style: TextStyle(
                      fontSize: 24,
                      color: state ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.read<LedCubit>().toggleLed(),
                    child: const Text('Toggle LED'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
