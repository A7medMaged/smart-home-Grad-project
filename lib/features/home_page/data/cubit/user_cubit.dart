import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/core/repo/auth_repo.dart';
import 'package:smart_home_app/features/home_page/data/user_model.dart';

import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final AuthRepo authRepo;

  UserCubit(this.authRepo) : super(UserInitial());

  Future<void> fetchCurrentUser() async {
    emit(UserLoading());
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userData = await authRepo.getUserDetails(currentUser.uid);
        final user = UserModel.fromMap(userData);
        emit(UserLoaded(user));
      } else {
        emit(const UserError('No user logged in'));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
