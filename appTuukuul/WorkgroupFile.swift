//
//  WorkgroupFile.swift
//  appTuukuul
//
//  Created by Developer on 9/4/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import UIKit
import Mapper

struct WorkgroupFile : Mappable {
    static let kId = "id"
    static let kName = "name"
    static let kExt = "ext"
    static let kSize = "size"
    static let kPath = "path"
    static let kShared = "shared"
    
    var id: String?
    var name: String?
    var ext: String?
    var size: String?
    var path: String?
    var shared: String?
    
    init(map: Mapper) throws {
        self.id = map.optionalFrom("id")
        self.ext = map.optionalFrom(WorkgroupFile.kExt)
        self.name = map.optionalFrom(WorkgroupFile.kName)
        self.size = map.optionalFrom(WorkgroupFile.kSize)
        self.path = map.optionalFrom(WorkgroupFile.kPath)
        self.shared = map.optionalFrom(WorkgroupFile.kShared)
    }
    init() {
    }
    
}
