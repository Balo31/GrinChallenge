//
//  pawWS.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/19/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation

class MyRequestController {
    
    func sendRequestAddDevice(device: [String : Any], onSuccess: @escaping (AnyObject) -> (), onError: @escaping (NSError) -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        /* Create the Request:
         Request (POST https://grin-bluetooth-api.herokuapp.com/add)
         */
        guard var URL = URL(string: "https://grin-bluetooth-api.herokuapp.com/add") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        
        // Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // JSON Body
        let bodyObject: [String : Any] = device
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])

        print(request.debugDescription)
        print(request.allHTTPHeaderFields ?? "no headers")
        print(request.httpMethod ?? "no method")
        print(request.httpBody ?? "no body")
        
        // Task
        let task = session.dataTask(with: request, completionHandler:
        {
            (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                var responseDictionary: AnyObject?
                var responseObject: AnyObject?
                
                if (data?.count)! > 0 {
                    
                    do {
                        if let dictionaryOK = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                            
                            responseObject = dictionaryOK as AnyObject?
                            print(responseObject ?? "Empty Object")
                        }else{
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
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
                onError(error! as NSError)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func sendRequestGetDevice( onSuccess: @escaping (AnyObject) -> (), onError: @escaping (NSError) -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        /* Create the Request:
         https://grin-bluetooth-api.herokuapp.com/devices?useNewUrlParser=true (GET https://grin-bluetooth-api.herokuapp.com/devices)
         */
        guard var URL = URL(string: "https://grin-bluetooth-api.herokuapp.com/devices") else {return}
        let URLParams = [
            "useNewUrlParser": "true",
        ]
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        // Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Task
        let task = session.dataTask(with: request, completionHandler:
        { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                
                var responseDictionary: AnyObject?
                var responseObject: AnyObject?
                
                if (data?.count)! > 0 {
                    
                    do {
                        if let dictionaryOK = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                            
                            responseObject = dictionaryOK as AnyObject?
                            print(responseObject ?? "Empty Object")
                        }else{
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
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
                onError(error! as NSError)
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}


protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension URL {
    /**
     Creates a new URL by adding the given query parameters.
     @param parametersDictionary The query parameter dictionary to add.
     @return A new URL.
     */
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
