//
//  DeviceBluetoothConnecter.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/20/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation
import CoreBluetooth

class PendingOperations {
    lazy var connectionInProgress: [IndexPath: Operation] = [:]
    lazy var connectingQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Connecting queue"
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
    
    lazy var getInformationInProgress: [IndexPath: Operation] = [:]
    lazy var gettingInfoQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Get Information queue"
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
}

class DeviceBluetoothConnector: Operation {

    let peripheralRecord: CBPeripheral
    let centralManager: CBCentralManager

    init(_ peripheralRecord: CBPeripheral, _ centralManager: CBCentralManager) {
        self.peripheralRecord = peripheralRecord
        self.centralManager = centralManager
    }

    override func main() {
        if isCancelled {
            return
        }
        
        guard self.peripheralRecord.state == .disconnected else {
            return
        }
        
        self.centralManager.connect(self.peripheralRecord)
        
        if isCancelled {
            return
        }
        
    }
}

