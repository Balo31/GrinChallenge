//
//  HUDs.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/18/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation
import UIKit

public class HUDs : NSObject {
    
    static let sharedInstance = HUDs()
    
    var hud: HUD?
    var isActive = false
    
    override init() {
        super.init()
        self.hud = HUD.instantiateFromNib()
    }
    
    func showHUD()  {
        let topView = UIApplication.topViewController()?.view
        self.hud?.showHUD(onView: topView!)
        self.isActive = true
    }
    
    func showHUDwithMessage (message: String) {
        DispatchQueue.main.async {
            if self.isActive {
                self.hudMessageCambio(message: message)
            } else {
                let topView = UIApplication.topViewController()?.view
                self.hud?.showHUDWithMessage(message: message, view: topView!)
                self.isActive = true
            }
        }
    }
    func dismiss() {
        DispatchQueue.main.async() {
            self.hud?.dismissHUD()
            self.isActive = false
        }
    }
    func hudMessageCambio(message: String){
        self.hud?.HUDMessageLabel.isHidden = false
        self.hud?.HUDMessageLabel.text = message
    }
    
}

