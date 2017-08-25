//
//  UserActions.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//


import Foundation
import ReSwift
import ReSwiftRecorder

struct LogInAction: Action {
    static let type = "LOGIN_ACTION"
    var email: String!
    var password: String!
    init(password: String, email: String) {
        self.email = email
        self.password = password
    }

}

struct LogOutAction: StandardActionConvertible {
    static let type = "LOGOUT_ACTION"
    init() {}
    init(_ standardAction: StandardAction) {
    }
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: LogOutAction.type, payload: [:], isTypedAction: true)
    }
}
struct ChangePassAction: StandardActionConvertible {
    static let type = "CHANGEPASS_ACTION"
    var oldPass: String!
    var newPass: String!
    
    init(old: String, new: String) {
        oldPass = old
        newPass = new
    }
    init(_ standardAction: StandardAction) {
    }
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: ChangePassAction.type, payload: [:], isTypedAction: true)
    }
}
struct GetUserAction: StandardActionConvertible {
    static let type = "USER_ACTION_GET"
    var uid: Int!
    var email: String!
    init(uid: Int) {
        self.uid = uid
    }
    init(email: String) {
        self.email = email
    }
    init() {
        
    }
    init(_ standardAction: StandardAction) {
    }
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: GetUserAction.type, payload: [:], isTypedAction: true)
    }
}

