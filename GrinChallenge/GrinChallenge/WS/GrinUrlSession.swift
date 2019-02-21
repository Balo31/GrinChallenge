//
//  UrlSession.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/18/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation

let NO_CON = "No coneccion"

class GrinUrlSession {
    
    static let sharedInstance = GrinUrlSession()
    var count:Int = 0
    
    func sendRequest(params : Dictionary<String, AnyObject>?,
                     method: String,
                     methodParam: Dictionary<String,String>?,
                     type: RequestType,
                     selectedConection: ConectionType,
                     onSuccess: @escaping (AnyObject) -> (),
                     onError: @escaping (alertCode, AnyObject?) -> (),
                     timer: Int?,
                     loopMax: Int?)
    {
        
        
        
        if(timer != nil && (count != 0 && loopMax != nil && loopMax! > 1)
            ){
            sleep(UInt32(timer!))
        }
        
        var loopMaximum : Int = 1
        
        if loopMax != nil {
            loopMaximum = loopMax!
        }
        
        self.count += 1
        print("loop :\(self.count)/\(loopMaximum)")
        
        let errorCallback = { (errorCode , response) in
            
            if(self.count < loopMaximum){
                self.sendRequest(params: params, method: method, methodParam: methodParam, type: type,selectedConection:selectedConection, onSuccess: onSuccess, onError: onError, timer: timer, loopMax: loopMax)
            }else{
                if response == nil{
                    onError(errorCode , nil)
                }else{
                    onError(errorCode , response)
                }
            }
            } as (alertCode, AnyObject?) -> ()
        
        self.sendRequest(params: params, method: method, methodParam: methodParam, type: type,selectedConection: selectedConection,onSuccess: onSuccess,onError: errorCallback)
    }
    
    func sendRequest(params : Dictionary<String, AnyObject>?,
                     method: String,
                     methodParam: Dictionary<String,String>?,
                     type: RequestType,
                     selectedConection: ConectionType,
                     onSuccess: @escaping (AnyObject) -> (),
                     onError: @escaping (alertCode, AnyObject?) -> ())
    {
        var methodExt = method
        if(methodParam != nil && !(methodParam?.isEmpty)!){
            
            if(methodParam?.count == 1){
                // if there only one element
                let methodParamValue = methodParam != nil ? methodParam?.first?.value : ""
                methodExt = method + methodParamValue!
                
            }else{
                // Parser "method Ext" String in order to get template mustache keys
                var keys: Array<String>? = Array()
                let characters = Array(methodExt)
                for var i in 0 ..< characters.count {
                    var key = ""
                    if  characters[i] == "{" &&
                        characters[i+1] == "{" &&
                        characters[i+2] != "{" {
                        var idx = i + 2
                        repeat {
                            
                            let char = characters[idx].description
                            key += char
                            idx += 1
                            
                        } while characters[idx].description != "}"
                        i = idx
                    }
                    if key != "" {
                        keys?.append(key)
                    }
                }
                // replace keys from values
                for key in keys! {
                    if methodParam?[key] != nil{
                        let value = methodParam?[key]
                        methodExt = methodExt.replacingOccurrences(of: "{{" + key + "}}", with: value!)
                    }
                }
            }
            
        }
        
        print("methodExt : ",methodExt)
        
        let successCallback =
        {(data) in
            if let serviceResponse = data as? [AnyObject]
            {
                let servicioType = selectedConection
                switch (servicioType) {
                case .serverGrin:
                    let response = ResponseWS(array: serviceResponse as! [[String : AnyObject]])
                    onSuccess(response as AnyObject)
                    return
                }
            }else if let serviceResponse = data as? [String:AnyObject]{
                let servicioType = selectedConection
                switch (servicioType) {
                case .serverGrin:
                    let response = ResponseWS(array: [serviceResponse])
                    onSuccess(response as AnyObject)
                    return
                }
            }else {
                onError(alertCode.AlertRepuestaCorrupto, nil)
                return
            }
            } as (AnyObject) -> ()
        
        let errorCallback =
        {(error) in
            print(error)
            onError(AlertHelper.convertErrorCodeinAlertCode(errorCode: error.code),nil)
            } as (AnyObject) -> ()
        

        if Reachability.isConnectedToNetwork() {
//            HTTPClient.sharedInstance.doRequestProcess(
//                method: methodExt,
//                type: type,
//                selectedConection: selectedConection,
//                parameters: params,
//                onSuccess: successCallback,
//                onError: errorCallback)
            
            let req = MyRequestController()
            if methodExt == GrinMethod.DevicesGet.rawValue{
                req.sendRequestGetDevice(onSuccess: successCallback, onError: errorCallback)
            }else if methodExt == GrinMethod.AddPost.rawValue{
                req.sendRequestAddDevice(
                    device:[
                            "name": "device1",
                            "address": "00:11:22:33:FF:EE",
                            "strength": "-20db"],
                    onSuccess: successCallback,
                    onError: errorCallback)
            }
        }else{
            onError(alertCode.AlertErrorConection, nil as AnyObject?)
        }
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let trust = challenge.protectionSpace.serverTrust,
                let pem = Bundle.main.path(forResource: "https", ofType: "cer"),
                let data = NSData(contentsOfFile: pem),
                let cert = SecCertificateCreateWithData(nil, data) {
                let certs = [cert]
                SecTrustSetAnchorCertificates(trust, certs as CFArray)
                
                completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: trust))
                return
            }
        }
        
        // Pinning failed
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
    }
}
