//
//  WorkgroupState.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import ReSwift
struct WorkgroupState: StateType {
    var workgroups = [Workgroup]()
    var workgroup:Workgroup!
    var status: Result<Any>
    var tasks = [WorkgroupTask]()
    var files = [WorkgroupFile]()
}
