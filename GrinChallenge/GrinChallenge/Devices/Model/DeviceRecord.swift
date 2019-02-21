//
//  DeviceRecord.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/21/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

enum DeviceRecordState {
    case new, connected, gettingInfo, infoGetted, saved
}

enum DeviceRecordType{
    case undeterminated, tv, watch, phone, laptop
    func image() -> UIImage{
        switch self {
        case .undeterminated: return UIImage(named:"twotone_phone_iphone_black_48pt")!
        case .laptop: return UIImage(named: "round_laptop_black")!
        case .tv: return UIImage(named: "round_tv_black")!
        case .watch: return UIImage(named:"round_watch_black")!
        default: return UIImage(named:"twotone_phone_iphone_black_48pt")!
        }
    }
}

class DeviceRecord {
    let deviceBluetooth: CBPeripheral
    var deviceWS: WSDevice? = nil
    var state = DeviceRecordState.new
    var image = UIImage(named:"twotone_phone_iphone_black_48pt")
    
    var checkStrength   = false
    var checkAddress    = false

    init(deviceBluetooth: CBPeripheral) {
        self.deviceBluetooth = deviceBluetooth
    }
    
    func valid() -> Bool{
        return checkStrength && checkAddress
    }
}
