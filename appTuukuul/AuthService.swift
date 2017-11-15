//
//  AuthService.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import Mapper
enum AuthService {
    case login(username: String, password: String)
}
extension AuthService: TargetType, AccessTokenAuthorizable {
    var baseURL: URL { return URL(string: Constants.ServerApi.url)! }
    var path: String {
        switch self {
        case .login:
            return "login/"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    var shouldAuthorize: Bool {
        switch self {
        case .login:
            return false
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .login(let username, let password):
            let data = ["username": username,
                         "password": password]
            return data
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .login:
            return JSONEncoding.default// Send parameters in URL for GET, DELETE and HEAD. For other HTTP methods, parameters will be sent in request body
        }
    }
    var sampleData: Data {
        switch self {
        case .login(_,_):
            return "{\"name\": \"Michel Queen\"}".utf8Encoded
        }
    }
    var task: Task {
        switch self {
        case .login:
            return .request
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
        //return ["Content-type": "application/x-www-form-urlencoded"]
    }
    
    
    
    
}
