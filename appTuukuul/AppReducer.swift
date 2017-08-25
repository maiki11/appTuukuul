//
//  AppReducer.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter
struct AppReducer: Reducer {
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        
        return AppState(
            userState: UserReducer().handleAction(action: action, state: state?.userState),
            workgroupState: WorkgroupReducer().handleAction(action: action, state: state?.workgroupState)
        )
    }
    
}
