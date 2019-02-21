//
//  AlertHelper.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/18/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation
import UIKit

enum alertCode:Int
{
    // Splash config error
    case AlertNoSimCard = 20000
    
    // WEB SERVICIO error manejado en app
    case AlertTimeOut = -1001
    case AlertConnecionInternetDesactivada = -1009
    case AlertErrorConection = 404
    
    // General error manejado en app
    case AlertRepuestaCorrupto = 5
    case AlertErrorFatal = -99
    case NoAlert = 0
    case NoError = 1
    
    // General error no manejado en app
    case AlertErrorDefault = -1

}

public class AlertHelper {
    
    class func convertErrorCodeinAlertCode(errorCode:Int! = 0)->alertCode{
        
        switch errorCode {
            
        case 0:
            return alertCode.NoAlert
        case -99:
            return alertCode.AlertErrorFatal
        case 404:
            return alertCode.AlertErrorConection
        case -1001 :
            return alertCode.AlertTimeOut
        case -1005 :
            return alertCode.AlertTimeOut
        case -1009 :
            return alertCode.AlertConnecionInternetDesactivada
        default:
            return alertCode.AlertErrorDefault
        }
    }
    
    class func showStandarAlertWithOneButton (code: alertCode,
                                              mensaje: String?,
                                              viewController: UIViewController,
                                              handler: ((UIAlertAction) -> Swift.Void)? = nil,
                                              _ actionSup : UIAlertAction? = nil) {
        
        var title:String = ""
        var message:String = ""
        var buttonTitle:String = ""
        var completion:((UIAlertAction) -> Swift.Void)? = handler
        let action2:(UIAlertAction)? = actionSup
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        switch code{
        case alertCode.AlertNoSimCard:
            title = "¡Este Móvil no Tiene SIM Card!"
            message =  "Challenge Grin Necesita Una SIM Card Para Funcionar"
            buttonTitle = "Aceptar"
            completion = { (action) in killApp() } as (UIAlertAction) -> ()
            
        case alertCode.AlertTimeOut:
            title = "¡Tiempo Fuera!"
            message =  "Se Acabo el Tiempo de Espera en la Petición"
            buttonTitle = "Aceptar"
            
        case alertCode.AlertConnecionInternetDesactivada:
            title = "¡Error de Conexión!"
            message =  "La Conexión a Internet Parece estar Desactivada."
            buttonTitle = "Aceptar"
            
        case alertCode.AlertErrorConection:
            title = "¡Error de conexión!"
            message = "No Cuentas con Conexión a Internet, Por Favor Revisa Tu Conexión e Intenta de Nuevo."
            buttonTitle = "Aceptar"
            
        case alertCode.AlertErrorFatal:
            title = "¡Error!"
            message =  "Ocurrió un Error Inesperado, La Aplicación se Cerrará."
            buttonTitle = "Aceptar"
            completion = { (action) in
                self.killApp()}
            
            
        case alertCode.AlertErrorDefault:
            title = "¡Error!"
            
            message =  (mensaje == nil || (mensaje?.isEmpty)! || mensaje == "") ? "Ocurrió un Error Inesperado": mensaje!
            buttonTitle = "Aceptar"
            
        case .AlertRepuestaCorrupto:
            title = "¡Error!"
            message =  "Repuesta Servidor Fallida"
            buttonTitle = "Aceptar"
            
            
        //MARK: - Default
        case .NoError:
            title = "¡Atención!"
            message =  ((mensaje?.isEmpty)! || mensaje == "") ? "": mensaje!
            buttonTitle = "Aceptar"
        case alertCode.NoAlert:
            return
        }
        
        
        alertController.title = title
        alertController.message = message
        
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: completion))
        
        if (action2 != nil){
            alertController.addAction(action2!)
        }
        
        viewController.present(alertController, animated: true, completion: {})
        
    }
    class func killApp(){
        UserDefaults.resetStandardUserDefaults()
        exit(0)
    }
}
