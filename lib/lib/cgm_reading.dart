part of cg_monitor;

class CGMReading {
  final String uid;
  final String state;
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
      state: json['state'],
      raw: json['raw'],
      patchUID: json['patchUID'],
      history: json['history'],
      trend: json['trend'],
      minutesSinceStart: json['minutesSinceStart'],
    );
  }
}
