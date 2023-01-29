//
//  NFCGManagerInterface.swift
//  basis_nfc_gm
//
//  Created by Michael Jajou on 1/27/23.
//

import Foundation

protocol CGMonitorInterface {
    func activateCGM(completion: @escaping (CGMReading) -> Void)
    func disposeNFC()
    func scanCGM(completion: @escaping (CGMReading) -> Void)
}
