import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_app/core/test/led_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LedCubit extends Cubit<bool> {
  final LedRepository _repository;
  StreamSubscription? _ledStatusSubscription;
  static const String _prefsKey = 'led_state';
  bool _isClosed = false;

  LedCubit(this._repository) : super(false) {
    _initialize();
  }

  Future<void> _initialize() async {
    if (_isClosed) return;

    try {
      // First try to load from local cache
      final prefs = await SharedPreferences.getInstance();
      final cachedStatus = prefs.getBool(_prefsKey);

      if (cachedStatus != null && !_isClosed) {
        emit(cachedStatus);
        // Optionally sync this state to Firebase
        await _repository.updateLedStatus(cachedStatus);
      }

      // Then get current status from Firebase
      final initialStatus = await _repository.getLedStatus();
      if (!_isClosed) {
        emit(initialStatus);
        await prefs.setBool(_prefsKey, initialStatus);
      }

      // Subscribe to real-time updates
      _ledStatusSubscription = _repository.ledStatusStream().listen((status) {
        if (!_isClosed) {
          emit(status);
          // Update local cache when Firebase updates
          prefs.setBool(_prefsKey, status);
        }
      });
    } catch (e) {
      // Handle any errors that might occur during initialization
      if (!_isClosed) {
        emit(false); // Default to OFF state in case of error
      }
    }
  }

  Future<void> toggleLed() async {
    if (_isClosed) return;

    try {
      final newState = !state;
      // Update both Firebase and local cache
      await _repository.updateLedStatus(newState);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_prefsKey, newState);
    } catch (e) {
      // Handle any errors during toggle
    }
  }

  @override
  Future<void> close() async {
    _isClosed = true;
    await _ledStatusSubscription?.cancel();
    return super.close();
  }
}
