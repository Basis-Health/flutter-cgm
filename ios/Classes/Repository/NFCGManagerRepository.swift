//
//  NFCManagerRepository.swift
//  basis_nfc_gm
//
//  Created by Michael Jajou on 1/27/23.
//

import Foundation
import Combine


// UID Format: 1A 86 06 0A 00 A0 07 E0
// Patch Info Format: A2 08 00 01 4D 21
class CGMonitor: CGMonitorInterface {
    private var subscriptionReading : AnyCancellable?
    private var subscriptionActivation : AnyCancellable?
    private let nfcManager: NFCManager = LibreTools.makeNFCManager(
        unlockCode: 0xA4,
        password: Data([0xc2, 0xad, 0x75, 0x21])
    )
    
    func activateCGM(completion: @escaping (CGMReading) -> Void) {
        subscriptionActivation = nfcManager.perform(.activate)
          .sink { reading in
              var rawStr = String("\(reading)")
              let uid = self.dataToJson(value: self.getDataFrom(from: rawStr, seperator: "UID: ", expectedLength: 23))
              let patchUID = self.dataToJson(value: self.getDataFrom(from: rawStr, seperator: "Patch Info: ", expectedLength: 17))
              let reading = CGMReading(
                uid: uid,
                state: .new,
                raw: rawStr,
                patchUID: patchUID,
                minutesSinceStart: reading.getMinutesSinceStart()
              )
              completion(reading)
              self.disposeActivationSubscription()
          }
    }
    
    func scanCGM(completion: @escaping (CGMReading) -> Void) {
        subscriptionReading = nfcManager.perform(.readHistory)
            .sink { reading in
                let sensorData = reading.sensorData
                var rawStr = String("\(reading)")
                let uid = self.dataToJson(value: self.getDataFrom(from: rawStr, seperator: "UID: ", expectedLength: 23))
                let patchUID = self.dataToJson(value: self.getDataFrom(from: rawStr, seperator: "Patch Info: ", expectedLength: 17))
                rawStr = rawStr.replacingOccurrences(of: "\"", with: "'")
                // if reading contains string 'Tag state: new' and we don't have an activation subscription yet
                // we want to try and activate the sensor with the .activate command
                let state = CGMState.allCases.first(where: { rawStr.contains($0.tagState) }) ?? .unknown
                var reading = CGMReading(
                    uid: uid,
                    state: state,
                    raw: rawStr,
                    patchUID: patchUID,
                    minutesSinceStart: reading.getMinutesSinceStart()
                )
                if state == .operational, let sensorData = sensorData {
                    reading.history = sensorData.glucoseTrend
                    reading.trend = sensorData.glucoseTrend
                }
                completion(reading)
                self.disposeDataSubscription()
            }
    }
    
    private func getDataFrom(from value: String, seperator: String, expectedLength: Int) -> String? {
        let uidInfoSubstring = value.components(separatedBy: seperator)
        if uidInfoSubstring.count < 2 {
            return nil
        }
        return Array(uidInfoSubstring.last!.map({ String($0) }).prefix(expectedLength)).joined(separator: "")
    }
    
    private func dataToJson(value: String?) -> String {
        if value == nil {
            return "null"
        }
        let replaced = value!
            .replacingOccurrences(of: "\"", with: "\\\"")
            .replacingOccurrences(of: "\\", with: "\\\\")
        return "\"\(replaced)\""
    }
    
    // MARK - Dispose
    func disposeNFC() {
        disposeActivationSubscription()
        disposeDataSubscription()
    }
    
    private func disposeActivationSubscription() {
        subscriptionActivation?.cancel()
        subscriptionActivation = nil
    }
    
    private func disposeDataSubscription() {
        subscriptionReading?.cancel()
        subscriptionReading = nil
    }
}

extension Reading {
    func getMinutesSinceStart() -> Int {
        let key = "minutesSinceStart: "
        let rawStr = String("\(self)")
        if let sensorData = sensorData {
            return sensorData.minutesSinceStart
        } else if rawStr.contains(key) {
            let numStr = rawStr.components(separatedBy: key)
                .last?
                .components(separatedBy: .whitespacesAndNewlines)
                .first
            return Int(numStr ?? "") ?? 0
        } else {
            return 0
        }
    }
}
