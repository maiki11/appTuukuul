//
//  User.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import UIKit
import Mapper

struct User : Mappable {
    static let kName = "name"
    static let kEmail = "email"
    static let kWorkgroupActive = "workgroup"
    
    var id: Int?
    var name: String?
    var email: String?
    var workgroup = [Workgroup]()
    
    init(map: Mapper) throws {
        try self.id = map.from("id")
        try self.email = map.from(User.kEmail)
        try self.name = map.from(User.kName)
        
        self.workgroup = map.optionalFrom(User.kWorkgroupActive) ?? []
    }
    init() {
    }
    
}
protocol UserBindible: AnyObject {
    var user: User! {get set}
    var nameLbl: UILabel! {get}
    var emailLbl: UILabel! {get}
}
extension UserBindible {
    var nameLbl: UILabel! {return nil}
    var emailLbl: UILabel! {return nil}
    
    func bind(user: User) -> Void {
        self.user = user
        bind()
    }
    func bind() -> Void {
        guard let user = self.user else {
            return
        }
        if let nameLbl = self.nameLbl {
            nameLbl.text = user.name
        }
        if let emailLbl = self.emailLbl {
            emailLbl.text = user.email
        }
    }
}
