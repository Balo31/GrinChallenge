//
//  UIApplicationExtension.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/18/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func mainViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as?
            UINavigationController {
            return mainViewController(controller: navigationController.visibleViewController)
        }
        if let presented = controller?.presentedViewController {
            
            return mainViewController(controller: presented)
        }
        return controller
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
