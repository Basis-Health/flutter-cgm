// ignore_for_file: constant_identifier_names

part of cg_monitor;

class CGMReading {
  final String uid;
  final CGMState state;
  final String raw;
  final String patchUID;
  final String? history;
  final String? trend;
  final int minutesSinceStart;

  CGMReading({
    required this.uid,
    required this.state,
    required this.raw,
    required this.patchUID,
    this.history,
    this.trend,
    required this.minutesSinceStart,
  });

  factory CGMReading.fromJson(Map<String, dynamic> json) {
    return CGMReading(
      uid: json['uid'],
      state: CGMState.fromString(json['state']),
      raw: json['raw'],
      patchUID: json['patchUID'],
      history: json['history'],
      trend: json['trend'],
      minutesSinceStart: json['minutesSinceStart'],
    );
  }
}

enum CGMState {
  NEW,
  ACTIVATING,
  UNKNOWN,
  OPERATIONAL;

  static CGMState fromString(String val) {
    try {
      return CGMState.values.firstWhere((e) => e.name == val);
    } catch (_) {
      return CGMState.UNKNOWN;
    }
  }
}
