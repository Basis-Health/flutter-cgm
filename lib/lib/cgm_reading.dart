part of cg_monitor;

class CGMReading {
  final String uid;
  final String state;
  final String raw;
  final String patchUID;
  final String? history;
  final String? trend;

  CGMReading({
    required this.uid,
    required this.state,
    required this.raw,
    required this.patchUID,
    this.history,
    this.trend,
  });
}
