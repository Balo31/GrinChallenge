//
//  UIGestureRecogniserExtension.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/20/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import UIKit
import CoreBluetooth

public extension CBPeripheralState {
//    public var isStartingState: Bool {
//        return self == .began
//    }
//
//    public var isTerminatingState: Bool {
//        return self == .cancelled || self == .ended || self == .failed
//    }
    
    func description()-> String{
        var desc = "error"
        switch self{
        case .connected: desc = "connected"
        case .connecting: desc = "connecting"
        case .disconnected: desc = "disconnected"
        case .disconnecting: desc = "disconnecting"
        @unknown default: desc = "default"
        }
        return desc
    }
}
