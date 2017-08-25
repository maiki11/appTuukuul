//
//  Constants.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import Alamofire
import Whisper
struct Constants {
    struct ServerApi {
        static let url = "http://tuukuul.net/index.php/Api/"
        static let fileurl = "http://tuukuul.net/index.php/Api/"
        static let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
    }
    struct Announcement {
        static let notLogin = Message(title: "Email/Contraseña incorrecta", backgroundColor: .red)
        static let errorG = Message(title: "Ups!! Ocurrio un error", backgroundColor: .red)
        static let errorG_Murmur = Murmur(title: "Ups!! Ocurrio un error")
        static let loginFail_Murmur = Murmur(title: "Email/Contraseña incorrecta", backgroundColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        static let succesG = Message(title: "Todo se efectuo correctamente!", backgroundColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
        
    }
    
}
typealias api = Constants.ServerApi
typealias messages = Constants.Announcement
