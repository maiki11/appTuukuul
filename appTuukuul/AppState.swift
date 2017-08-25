//
//  AppState.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType{
    var userState : UserState
    var workgroupState: WorkgroupState
    //var reportState: ReportState
}
enum Result<T> {
    case loading
    case failed
    case Failed(T)
    case finished
    case Finished(T)
    case noWorkgroups
    case none
}
