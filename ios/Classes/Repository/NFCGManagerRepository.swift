//
//  NFCManagerRepository.swift
//  basis_nfc_gm
//
//  Created by Michael Jajou on 1/27/23.
//

import Foundation
import Combine

class CGMonitor: CGMonitorInterface {
    var subscriptionReading : AnyCancellable?
    var subscriptionActivation : AnyCancellable?
    
    func activateCGM(completion: @escaping (CGMReading) -> Void) {
        fatalError()
    }
    
    func disposeNFC() {
        subscriptionReading?.cancel()
        subscriptionReading = nil
        subscriptionActivation?.cancel()
        subscriptionActivation = nil
    }
    
    func scanCGM(completion: @escaping (CGMReading) -> Void) {
        fatalError()
    }
}
