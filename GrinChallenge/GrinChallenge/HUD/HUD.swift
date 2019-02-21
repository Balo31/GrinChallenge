//
//  HUD.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/18/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import UIKit

class HUD: UIView {
    
    
    var view: UIView!
    
    @IBOutlet weak var HUDImage: UIImageView!
    @IBOutlet weak var HUDMessageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func showHUD(onView: UIView) {
        HUDMessageLabel.isHidden = true
        let superView = UIApplication.shared.keyWindow
        // Overlay view to uncapacitate users interaction
        let viewAlert = UIView()
        viewAlert.frame = UIScreen.main.bounds
        //let blurEffectView = self.blurEffect()
        let shadowEffectView = self.shadowEffect()
        // Resize and Center AlertView
        self.frame = self.getAlertFrameConfig()
        // Add Alert and effect to the Overlay view
        viewAlert.addSubview(shadowEffectView)
        viewAlert.addSubview(self)
        // Add Overlay VIew
        superView?.addSubview(viewAlert)
    }
    
    func showHUDWithMessage(message: String, view: UIView) {
        HUDMessageLabel.isHidden = false
        HUDMessageLabel.text = message
        
        let superView = UIApplication.shared.keyWindow;
        // Overlay view to uncapacitate users interaction
        let viewAlert = UIView()
        viewAlert.frame = UIScreen.main.bounds
        //let blurEffectView = self.blurEffect()
        let shadowEffectView = self.shadowEffect()
        // Resize and Center AlertView
        self.frame = self.getAlertFrameConfig()
        // Add Alert and effect to the Overlay view
        viewAlert.addSubview(shadowEffectView)
        viewAlert.addSubview(self)
        // Add Overlay VIew
        superView?.addSubview(viewAlert)
        animateImage()
    }
    
    func dismissHUD(){
        self.superview?.removeFromSuperview()
    }
    
    func blurEffect() -> UIView{
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
    func shadowEffect() -> UIView{
        
        let shadowEffectView = UIView()
        shadowEffectView.backgroundColor = UIColor(red:0.09, green:0.09, blue:0.09, alpha:0.8)
        shadowEffectView.frame = UIScreen.main.bounds
        shadowEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return shadowEffectView
    }
    
    func animateImage (){
        //let gifmanager = SwiftyGifManager(memoryLimit:20)
        let gif = UIImage(gifName: "refresh.gif")
        HUDImage.setGifImage(gif)
        
    }
    
    func getAlertFrameConfig() -> CGRect{
        let screenSize: CGRect = UIScreen.main.bounds
        return CGRect(x: screenSize.width/2 - 100, y: screenSize.height/2 - 200, width: 200, height: 200)
    }
    
    
}
