import 'package:firebase_database/firebase_database.dart';

class LedRepository {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  // Get current LED status
  Future<bool> getLedStatus() async {
    final snapshot = await _databaseRef.child('led/state').get();
    return (snapshot.value as int? ?? 0) == 1;
  }

  // Stream for real-time updates
  Stream<bool> ledStatusStream() {
    return _databaseRef.child('led/state').onValue.map((event) {
      return (event.snapshot.value as int? ?? 0) == 1;
    });
  }

  // Update LED status
  Future<void> updateLedStatus(bool status) async {
    await _databaseRef.child('led/state').set(status ? 1 : 0);
  }
}
