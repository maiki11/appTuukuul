//
//  Workgroup.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import UIKit
import Mapper

struct Workgroup : Mappable {
    static let kId = "id"
    static let kName = "name"
    static let kImg = "img"
//    static let kMembers = "members"
//    static let kAdmin = "admin"
//    static let kCover = "cover"
    
    var id: String?
    var name: String?
    var img: String?
//    var cover: String?
//    var admin: String?
    
    init(map: Mapper) throws {
        self.id = map.optionalFrom("id")
        self.img = map.optionalFrom(Workgroup.kImg)
        self.name = map.optionalFrom(Workgroup.kName)
//        try self.cover = map.from(Workgroup.kCover)
//        try self.admin = map.from(Workgroup.kAdmin)
        //try self.members = map.from(Workgroup.kMembers)
    }
    init() {
    }
    
}
protocol WorkgroupBindible: AnyObject {
    var workgroup: Workgroup! {get set}
    var nameLbl: UILabel! {get}
    var imgUIImage: UIImage! {get}
    var coverUIImage: UIImage! {get}
    var adminLbl: UILabel! {get}
}
extension WorkgroupBindible {
    var nameLbl: UILabel! {return nil}
    var adminLbl: UILabel! {return nil}
    var imgUIImage: UIImage! {return nil}
    var coverUIImage: UIImage! {return nil}
    
    func bind(workgroup: Workgroup) -> Void {
        self.workgroup = workgroup
        bind()
    }
    func bind() -> Void {
        guard let workgroup = self.workgroup else {
            return
        }
        if let nameLbl = self.nameLbl {
            nameLbl.text = workgroup.name
        }
//        if let adminLbl = self.adminLbl {
//            adminLbl.text = workgroup.admin
//        }
        /*if let imgUIImage = self.imgUIImage {
            imgUIImage = UIImage(contentsOfFile: workgroup.img!)
        }
        if let coverUIImage = self.coverUIImage {
            coverUIImage = UIImage(contentsOfFile: workgroup.cover!)
        }*/
    }
}
