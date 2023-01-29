part of cg_monitor;

abstract class CGMonitorInterface {
  Future<CGMReading> activateCGM();
  Future<void> disposeNFC();
  Future<CGMReading> scanCGM();
}

enum CGMonitorMethodCall {
  activateCGM,
  disposeNFC,
  scanCGM;
}
