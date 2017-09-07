//
//  WorkgroupTask.swift
//  appTuukuul
//
//  Created by Ernesto Salazar on 9/3/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import UIKit
import Mapper

struct WorkgroupTask : Mappable {
    static let kId = "id"
    static let kName = "name"
    static let kImg = "img"
    static let kDescription = "description"
    static let kStatus = "status"
    
    var id: String?
    var name: String?
    var img: String?
    var description: String?
    var status: String?
    
    init(map: Mapper) throws {
        self.id = map.optionalFrom("id")
        self.img = map.optionalFrom(WorkgroupTask.kImg)
        self.name = map.optionalFrom(WorkgroupTask.kName)
        self.description = map.optionalFrom(WorkgroupTask.kDescription)
        self.status = map.optionalFrom(WorkgroupTask.kStatus)
    }
    init() {
    }
    
}
