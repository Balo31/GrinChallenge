//
//  UserSettings.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/21/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation

struct USConst {
    static let ImagenAvatarURL = "ImagenAvatarURL"
}

public class UserSettings {
    // MARK: Avatar
    class func setAvatar(avatar:String?){
        let userDefaults = UserDefaults.standard
        userDefaults.set(avatar, forKey: USConst.ImagenAvatarURL )
        userDefaults.synchronize()
    }
    class func getAvatar () -> String? {
        let userDefaults = UserDefaults.standard
        if let AvatarBack = userDefaults.object(forKey: USConst.ImagenAvatarURL) as? String {
            return AvatarBack
        } else {
            return nil
        }
    }
}
