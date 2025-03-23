import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_home_app/core/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo = AuthRepo();
  LoginCubit(authRepo) : super(LoginInitial());
  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await _authRepo.login(email, password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
