//
//  UIViewExtension.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/17/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(
            String(describing: viewType),
            owner: nil,
            options: nil )?.first as! T
    }
    
    class func instantiateFromNib() -> Self {
        return instantiateFromNib(viewType: self)
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}
