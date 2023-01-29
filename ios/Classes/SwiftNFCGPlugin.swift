import Flutter
import UIKit

public class FlutterCgmPlugin: NSObject, FlutterPlugin {
    private let monitor = CGMonitor()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "basis.nfcg_manager", binaryMessenger: registrar.messenger())
        let instance = FlutterCgmPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let method = CGMonitorMethodCall(rawValue: call.method)
        switch method {
        case .activateCGM:
            activateCGM(result)
        case .disposeNFC:
            disposeNFC(result)
        case .scanCGM:
            scanCGM(result)
        default:
            print("Method not implemented")
        }
    }
    
    private func activateCGM(_ result: @escaping FlutterResult) {
        monitor.activateCGM { reading in result(reading.toData()) }
    }
    
    private func disposeNFC(_ result: @escaping FlutterResult) {
        monitor.disposeNFC()
    }
    
    private func scanCGM(_ result: @escaping FlutterResult) {
        monitor.scanCGM { reading in result(reading.toData()) }
    }
}
