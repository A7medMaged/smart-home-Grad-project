import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_home_app/core/repo/auth_repo.dart';
import 'package:smart_home_app/features/home_page/data/cubit/user_cubit.dart';
import 'package:smart_home_app/features/home_page/data/cubit/user_state.dart'
    show UserError, UserInitial, UserLoaded, UserLoading, UserState;

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: BlocProvider(
        create: (context) => UserCubit(AuthRepo())..fetchCurrentUser(),
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserInitial || state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else if (state is UserLoaded) {
              final user = state.user;
              final formattedDate = DateFormat('MMMM dd, yyyy - hh:mm a')
                  .format(user.registerTime);

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Name'),
                      subtitle: Text(user.name),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(user.email),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Phone'),
                      subtitle: Text(user.phone),
                    ),
                    ListTile(
                      leading: const Icon(Icons.people),
                      title: const Text('Role'),
                      subtitle: Text(user.role),
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text('Registered Since'),
                      subtitle: Text(formattedDate),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }
}
