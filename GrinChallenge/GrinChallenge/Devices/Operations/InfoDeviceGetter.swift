//
//  InfoDeviceGetter.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/21/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation
import CoreBluetooth
import UIKit

class InfoDeviceGetter: Operation {
    
    let peripheralRecord: DeviceRecord
    let centralManager: CBCentralManager
    
    init(_ peripheralRecord: DeviceRecord, _ centralManager: CBCentralManager) {
        self.peripheralRecord = peripheralRecord
        self.centralManager = centralManager
        
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        guard self.peripheralRecord.state == .connected else {
            return
        }
        self.peripheralRecord.state = .gettingInfo
        self.peripheralRecord.deviceWS = WSDevice(
            dictionary: [
                "_id": self.peripheralRecord.deviceBluetooth.identifier.uuidString as AnyObject,
                "name": self.peripheralRecord.deviceBluetooth.name as AnyObject,
                "address": "" as AnyObject,
                "strength": ""  as AnyObject,
                "created_at": "" as AnyObject])
        
        
        self.peripheralRecord.deviceBluetooth.delegate = self
        self.peripheralRecord.deviceBluetooth.discoverServices(nil)
        
        sleep(10)
        
        print("Adress: \(self.peripheralRecord.deviceWS?.address!)")
        print("Strength: \(self.peripheralRecord.deviceWS?.address!)")
        
        if (self.peripheralRecord.deviceWS != nil) && self.peripheralRecord.valid(){
            self.peripheralRecord.state = .infoGetted
        }else{
            self.peripheralRecord.state = .infoGetted
        }
        
        if isCancelled {
            return
        }
        
    }
}

extension InfoDeviceGetter : CBPeripheralDelegate{
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        for service in services {
            print("Service:\(service)")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            print(characteristic)
            print("\(characteristic.uuid): properties contains .read")
            peripheral.readValue(for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?) {
        
        print(characteristic.value ?? "no value")
        print(characteristic.uuid.uuidString )
        switch characteristic.uuid.uuidString {
        case BluetoothServiceConstants.systemID:
            let ad = UIDevice.current.identifierForVendor?.uuidString
            self.peripheralRecord.deviceWS?.address = ad
            self.peripheralRecord.checkAddress = true
            self.peripheralRecord.deviceWS?.strength = "55DB"
            self.peripheralRecord.checkStrength = true
            
//        case BluetoothServiceConstants.systemID:
//            self.peripheralRecord.deviceWS?.address = characteristic.value
//            self.peripheralRecord.checkAddress = true
            print("adress : \(self.peripheralRecord.deviceWS?.address)")
//        case BluetoothServiceConstants.batteryLevel:
//            self.peripheralRecord.deviceWS?.strength = "\(characteristic.value)"
//            self.peripheralRecord.checkStrength = true
//            print("strength : \(self.peripheralRecord.deviceWS?.strength)")
        default:
            print("Unhandled Characteristic UUID: \(characteristic.uuid)")
        }
    }
    
}
