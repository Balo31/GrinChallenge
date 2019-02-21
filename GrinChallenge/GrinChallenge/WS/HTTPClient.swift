//
//  HTTPClient.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/17/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import UIKit

enum RequestType: String {
    case post = "POST"
    case get = "GET"
    
}
enum ConectionType: Int {
    case serverGrin = 1
}

class HTTPClient: NSObject {
        
    static let sharedInstance = HTTPClient()
    
    private let SERVER_GRIN = "https://grin-bluetooth-api.herokuapp.com/"

    private let session: URLSession
    private let config: URLSessionConfiguration
    private var request: URLRequest?
    
    private var credential: URLCredential?
    private var user: String?
    private var password: String?
    
    var params : Dictionary <String,AnyObject>?
    var file : Dictionary <String,AnyObject>?
    
    var needHeaders: Bool?
    var headers: Dictionary <String,String>?
    // Usuario: es el correo del usuario, esta pidiendo en cada request header
    var usuario: String! = ""
    
    override init(){
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config,delegate: nil,delegateQueue: nil)
    }
    
    func doRequest(method: String, type: String, selectedConection: ConectionType,parameters: Dictionary<String, AnyObject>?, onSuccess: @escaping (AnyObject) -> (), onError: @escaping (NSError) -> ()) {
        
        prepareRequestWithMethod(method: method, type: type, selectedConection: selectedConection)
        
        if parameters != nil {
            do {
                print(parameters ?? "no params")
                request!.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: [])
                // use anyObj here
                
                
            } catch {
                request!.httpBody = "".data(using: String.Encoding.utf8, allowLossyConversion: false)
            }
        } else {
            request!.httpBody = "".data(using: String.Encoding.utf8, allowLossyConversion: false)
        }
        
        var task = URLSessionDataTask()
        task = session.dataTask(with: request! as URLRequest, completionHandler:
            {
                (data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                if error != nil {
                    onError(error! as NSError)
                    return
                }
                
                if error == nil{
                    let httpResponse = response as! HTTPURLResponse
                    print(httpResponse.statusCode)
                    
                    if (httpResponse.statusCode != 200) {
                        onError(NSError(domain: "Unexpected", code: httpResponse.statusCode, userInfo: [:]))
                        return
                    }
                    
                    var responseDictionary: AnyObject?
                    var responseObject: AnyObject?
                    
                    if (data?.count)! > 0 {
                        
                        do {
                            if let dictionaryOK = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                                
                                responseObject = dictionaryOK as AnyObject?
                                print(responseObject ?? "Empty Object")
                            } else {
                                if let dictionaryOK = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [AnyObject] {
                                    
                                    responseObject = dictionaryOK as AnyObject?
                                    print(responseObject ?? "Empty Object")
                                }
                            }
                        } catch {
                            print(error)
                        }
                    }
                    
                    let emptyDict : [String:String] = [:]
                    if responseObject == nil {
                        
                        responseDictionary = emptyDict as AnyObject?
                    }else {
                        switch responseObject {
                        case let validDict as Dictionary<String, AnyObject> :
                            print(validDict)
                            responseDictionary = responseObject as! Dictionary<String, AnyObject> as AnyObject?
                        case let arrayOfElements as NSArray:
                            print(arrayOfElements)
                            responseDictionary = arrayOfElements
                        default:
                            responseDictionary = emptyDict as AnyObject?
                            print("Se recibio un objeto no manejable")
                        }
                        
                    }
                    onSuccess(responseDictionary!)
                } else{
                    // Failure
                    print("URL Session Task Failed: %@", error!.localizedDescription);
                    onError(error! as NSError)
                }
        })
        
        print(request.debugDescription)
        print(request?.allHTTPHeaderFields ?? "no headers")
        print(request?.httpMethod ?? "no method")
        print(request?.httpBody ?? "no body")
        print("WillStart DataTask")
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func doRequestProcess(method: String, type: RequestType,selectedConection:ConectionType, parameters: Dictionary<String, AnyObject>?, onSuccess: @escaping (AnyObject) -> Void, onError: @escaping (NSError) -> Void) {
        doRequest(method: method, type: type.rawValue, selectedConection: selectedConection, parameters: parameters, onSuccess: onSuccess, onError: onError)
    }
    
    func updateCredentials(user: String, password: String) {
        //        self.user = user
        //        self.password = password
        //        credential = NSURLCredential(user: user, password: password, persistence: .ForSession)
    }
    
    func prepareRequestWithMethod(method: String, type: String, selectedConection:ConectionType) {
        var url = URL(string:"")
        
        switch (selectedConection) {
            
            //MARK: - HEADERS CONFIG SERVER
            
        case .serverGrin:
            url = URL(string: "\(SERVER_GRIN )\(method)")!
            let URLParams = [
                "useNewUrlParser": "true",
            ]
            url = url!.appendingQueryParameters(URLParams)
            request = URLRequest(url: url!)
            
            request!.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if(needHeaders == true){
                if(headers != nil){
                    for header in headers!{
                        request!.addValue(header.value, forHTTPHeaderField:header.key)
                    }
                }
            }
            
            break
        }
        let  emptyDict = [String: AnyObject]()
        
        if (params != nil){
            //print("Parametros: \(params)")
            let bodyString = self.stringFromQueryParameters(queryParameters: params ?? emptyDict)
            request!.httpBody = bodyString.data(using: String.Encoding.utf8, allowLossyConversion: true)
            
            
//            let bodyObject: [String : Any] = device
//            request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])
        }
        
        if (file != nil){
            let bodyString = file!.queryParameters
            request!.httpBody = bodyString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        }
        
        request!.httpMethod = type as String
        request!.timeoutInterval = 60
        
        print(request.debugDescription)
        print(request?.allHTTPHeaderFields ?? "no headers")
        print(request?.httpMethod ?? "no method")
        print(request?.httpBody ?? "no body")
    }
    
    
    
    func stringFromQueryParameters(queryParameters : Dictionary<String, AnyObject>) -> String {
        var parts: [String] = []
        for (name, value) in queryParameters {
            let part = NSString(format: "%@=%@",name.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!,value.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!)
            
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}

