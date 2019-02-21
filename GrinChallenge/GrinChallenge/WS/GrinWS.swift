//
//  GrinWS.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/18/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation
import UIKit

enum GrinMethod : String{
    
    case DevicesGet     = "devices"
    case AddPost        = "add"
}

//MARK: -
class GrinWebServicios {
    static let sharedInstance = GrinWebServicios()
    
    func grinRequest(   params:Dictionary<String, AnyObject>?,
                        usuario:String,
                        method:GrinMethod,
                        methodParam: Dictionary<String,String>?,
                        hudMsg:String,
                        headers:Dictionary<String,String>,
                        type:RequestType,
                        viewController: UIViewController?,
                        Success onSuccess: @escaping (ResponseWS) -> (),
                        Error onError: @escaping () -> (),
                        timer: Int?,
                        loopMax: Int?)
    {

        let selectedCon = ConectionType.serverGrin
        HTTPClient.sharedInstance.usuario = usuario
        
        let methodExt: String  = method.rawValue
        
        if(headers.isEmpty){
            HTTPClient.sharedInstance.needHeaders = false
        }else{
            HTTPClient.sharedInstance.needHeaders = true
            HTTPClient.sharedInstance.headers = headers
        }
        
        let background = hudMsg == ""
        
        if(!background){
            // Show HUD
            HUDs.sharedInstance.showHUDwithMessage(message: hudMsg)
        }else{
            print("WS Background")
        }
        
        let successCallBack = {(response) in
            if(!background){
                // Hide HUD
                HUDs.sharedInstance.dismiss()
            }
            
            onSuccess(response as! ResponseWS)
            
            } as ((AnyObject) ->())
        
        
        let errorCallBack = {
            (errorCode , response) in
            
            print("*ihm errorCode: \(errorCode)")

            if errorCode == alertCode.AlertErrorDefault{
                var msg : String = ""
                if( response != nil){
                    msg = "error default"
                }
                if (viewController != nil && !background){
                    DispatchQueue.main.async {
                        AlertHelper.showStandarAlertWithOneButton(
                            code: errorCode,
                            mensaje: msg,
                            viewController: viewController!,
                            handler:{(action) in
                                onError()
                                } as (UIAlertAction)->())
                    }
                }else{
                    onError()
                }
            }
            
            if(!background){
                // Hide HUD
                HUDs.sharedInstance.dismiss()
                // Show Alert error
                
                var msg : String = ""
                if( response != nil){
                    msg = "error default"
                }
                if (viewController != nil){
                    DispatchQueue.main.async {
                        AlertHelper.showStandarAlertWithOneButton(
                            code: errorCode,
                            mensaje: msg,
                            viewController: viewController!,
                            handler:{(action) in
                                onError()
                                } as (UIAlertAction)->())
                    }
                }else{
                     onError()
                }
            }else{
                onError()
            }
        } as (alertCode, AnyObject?) -> ()
        
        if(timer != nil || loopMax != nil){
            print("timer: " , timer ?? "no value")
            print("loopMax: " , loopMax ?? "no value")
            GrinUrlSession.sharedInstance.count = 0
            GrinUrlSession.sharedInstance.sendRequest(params: params,
                                                  method: methodExt,
                                                  methodParam: methodParam,
                                                  type: type,
                                                  selectedConection:selectedCon,
                                                  onSuccess: successCallBack,
                                                  onError: errorCallBack ,
                                                  timer:timer!,
                                                  loopMax:loopMax!)
        }else{
            GrinUrlSession.sharedInstance.sendRequest(params: params,
                                                  method: methodExt,
                                                  methodParam: methodParam,
                                                  type: type,
                                                  selectedConection:selectedCon,
                                                  onSuccess: successCallBack,
                                                  onError: errorCallBack )
        }
        
    }
}
extension GrinWebServicios{
    
    // MARK: - Get Devices
    func getDevices(
        verHud: Bool,
        viewController: UIViewController?,
        Success onSuccess:@escaping ([WSDevice]) -> (),
        Error onError: @escaping () -> ())
    {
        // Params
        let params = [String:AnyObject]()
        // Usuario
        let usuario = ""
        // HUD
        var hudMsg = "Get Devices"
        if !verHud  { hudMsg = "" }
        let method = GrinMethod.DevicesGet
        // Header
        let headers : [String:AnyObject]  = [String:AnyObject]()
        // POST/GET
        let type = RequestType.get
        // Completion
        let successCallBack = {(response) in
            onSuccess(response.list)
            
            }  as (ResponseWS) -> ()
        let errorCallBack   = {
            onError() } as () -> ()
        // Request
        self.grinRequest(
            params          : params as Dictionary<String, AnyObject>?,
            usuario         : usuario,
            method          : method,
            methodParam     : nil,
            hudMsg          : hudMsg,
            headers         : headers as! Dictionary<String, String>,
            type            : type,
            viewController  : viewController,
            Success         : successCallBack,
            Error           : errorCallBack,
            timer           : nil,
            loopMax         : nil)
    }
    
    // MARK: - Add Device
    func addDevices(
        name            : String,
        address         : String,
        strength        : String,
        verHud          : Bool,
        viewController  : UIViewController,
        Success onSuccess:@escaping ([WSDevice]) -> (),
        Error onError: @escaping () -> ())
    {
        // Params
        var params = [String:AnyObject]()
        params["name"] = name as AnyObject
        params["address"] = address as AnyObject
        params["strength"] = strength as AnyObject
        
        // Usuario
        let usuario = ""
        // HUD
        var hudMsg = "Add Device"
        if !verHud  { hudMsg = " " }
        let method = GrinMethod.AddPost
        // Header
        let headers = [String:AnyObject]()
        // POST/GET
        let type = RequestType.post
        // Completion
        let successCallBack = {(response) in
            onSuccess(response.list)
            
            }  as (ResponseWS) -> ()
        let errorCallBack   = { onError() } as () -> ()
        // Request
        self.grinRequest(
            params          : params as Dictionary<String, AnyObject>?,
            usuario         : usuario,
            method          : method,
            methodParam     : nil,
            hudMsg          : hudMsg,
            headers         : headers as! Dictionary<String, String>,
            type            : type,
            viewController  : viewController,
            Success         : successCallBack,
            Error           : errorCallBack,
            timer           : nil,
            loopMax         : nil)
    }
}
