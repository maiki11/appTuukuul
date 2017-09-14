//
//  WorkgroupPost.swift
//  appTuukuul
//
//  Created by Ernesto Salazar on 9/12/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import UIKit
import Mapper

struct WorkgroupPost : Mappable {
    static let kId = "id"
    static let kPost = "post"
    static let kUser = "user_id"
    static let kCreated = "created"
    static let kImg = "img"
    static let kFullName = "FullName"
    static let kfileType = "file_type"
    
    var id: String?
    var post: String?
    var user: String?
    var created: String?
    var img: String?
    var fullName: String?
    var fileType: String?
    
    init(map: Mapper) throws {
        self.id = map.optionalFrom("id")
        self.post = map.optionalFrom(WorkgroupPost.kPost)
        self.user = map.optionalFrom(WorkgroupPost.kUser)
        self.created = map.optionalFrom(WorkgroupPost.kCreated)
        self.img = map.optionalFrom(WorkgroupPost.kImg)
        self.fullName = map.optionalFrom(WorkgroupPost.kFullName)
        self.fileType = map.optionalFrom(WorkgroupPost.kfileType)
    }
    init() {
    }
    
}
