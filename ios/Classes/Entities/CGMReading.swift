//
//  CGMReading.swift
//  basis_nfc_gm
//
//  Created by Michael Jajou on 1/27/23.
//

import Foundation

class CGMReading {
    var uid: String = ""
    var state: CGMState = .unknown
    var raw: String = ""
    var patchUID: String = ""
    var history: [UInt16] = []
    var trend: [UInt16] = []
    var minutesSinceStart: Int = 0
    
    init(
        uid: String = "",
        state: CGMState = .unknown,
        raw: String = "",
        patchUID: String = "",
        history: [UInt16] = [],
        trend: [UInt16] = [],
        minutesSinceStart: Int = 0
    ) {
        self.uid = uid
        self.state = state
        self.raw = raw
        self.patchUID = patchUID
        self.history = history
        self.trend = trend
        self.minutesSinceStart = 0
    }
}

enum CGMState: String, CaseIterable {
    case new
    case activating
    case unknown
    case operational
    var tagState: String { "Tag state: \(rawValue)" }
}

extension CGMReading {
    func toData() -> NSDictionary {
        return [
            "uid": uid,
            "state": state.rawValue.uppercased(),
            "raw": raw,
            "patchUID": patchUID,
            "history": history,
            "trend": trend,
            "minutesSinceStart": minutesSinceStart,
        ]
    }
}
