import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/core/test/led_repo.dart';

class LedCubit extends Cubit<bool> {
  final LedRepository _repository;
  StreamSubscription? _ledStatusSubscription;

  LedCubit(this._repository) : super(false) {
    // Initialize with current status
    _initialize();
  }

  Future<void> _initialize() async {
    // Get initial status
    final initialStatus = await _repository.getLedStatus();
    emit(initialStatus);

    // Subscribe to real-time updates
    _ledStatusSubscription = _repository.ledStatusStream().listen((status) {
      emit(status);
    });
  }

  Future<void> toggleLed() async {
    // Update status in Firebase
    await _repository.updateLedStatus(!state);
    // State will update automatically through the stream
  }

  @override
  Future<void> close() {
    _ledStatusSubscription?.cancel();
    return super.close();
  }
}
