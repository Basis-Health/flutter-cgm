part of cg_monitor;

class CGMonitor implements CGMonitorInterface {
  static const MethodChannel _channel = MethodChannel('basis.nfcg_manager');
  static var instance = CGMonitor();

  @override
  Future<CGMReading> activateCGM() async {
    final response = await _channel.invokeMethod(CGMonitorMethodCall.activateCGM.name);
    return CGMReading.fromJson(response);
  }

  @override
  Future<void> disposeNFC() async {
    await _channel.invokeMethod(CGMonitorMethodCall.disposeNFC.name);
  }

  @override
  Future<CGMReading> scanCGM() async {
    final response = await _channel.invokeMethod(CGMonitorMethodCall.scanCGM.name);
    return CGMReading.fromJson(response);
  }
}
