class LedStatus {
  final bool isOn;

  LedStatus({required this.isOn});

  factory LedStatus.fromMap(Map<dynamic, dynamic> map) {
    return LedStatus(isOn: map['isOn'] ?? false);
  }

  Map<String, dynamic> toMap() {
    return {'isOn': isOn};
  }
}
