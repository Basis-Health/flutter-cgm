//
//  CGMReading.swift
//  basis_nfc_gm
//
//  Created by Michael Jajou on 1/27/23.
//

import Foundation

struct CGMReading: Codable {
    let uid: String
    let state: String
    let raw: String
    let patchUID: String
    let history: String?
    let trend: String?
}

extension CGMReading {
    func toData() -> [String: String?] {
        return [
            "uid": uid,
            "state": state,
            "raw": raw,
            "patchUID": patchUID,
            "history": history,
            "trend": trend
        ]
    }
}
