//
//  UserState.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import ReSwift
struct UserState: StateType {
    var user: User!
    var type: Int!
    var users = [User]()
    var status: Result<Any>
}
