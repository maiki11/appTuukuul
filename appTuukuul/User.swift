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
    static let kId = "id"
    static let kEmail = "email"
    static let kName = "name"
    static let kLastName = "lastname"
    static let kFullName = "fullName"
    static let kImg = "img"
    static let kCover = "cover"
    static let kOccupation = "occupation"
    static let kBirthday = "birthday"
    static let kGender = "gender"
    static let kCellphone = "cellphone"
    
    //static let kWorkgroupActive = "workgroup"
    
    var id: String?
    var name: String?
    var email: String?
    var lastname: String?
    var fullname: String?
    var occupation: String?
    var birthday: String?
    var cellphone: String?
    var gender: String?
    var img: String?
    var cover: String?
    //var workgroup = [Workgroup]()
    
    init(map: Mapper) throws {
        try self.id = map.from("id")
        try self.email = map.from(User.kEmail)
        try self.name = map.from(User.kName)
        try self.fullname = map.from(User.kFullName)
        try self.lastname = map.from(User.kLastName)
        try self.img = map.from(User.kImg)
        try self.cover = map.from(User.kCover)
        try self.occupation = map.from(User.kOccupation)
        try self.birthday = map.from(User.kBirthday)
        try self.gender = map.from(User.kGender)
        try self.cellphone = map.from(User.kCellphone)
        
        //self.workgroup = map.optionalFrom(User.kWorkgroupActive) ?? []
    }
    init() {
    }
    
}
protocol UserBindible: AnyObject {
    var user: User! {get set}
    var nameLbl: UILabel! {get}
    var emailLbl: UILabel! {get}
    var lastnameLbl: UILabel! {get}
    var fullnameLbl: UILabel! {get}
    var occupationLbl: UILabel! {get}
    var birthdayLbl: UILabel! {get}
    var cellphoneLbl: UILabel! {get}
    var genderStr: String! {get}
    var imgStr: String! {get}
    var coverStr: String! {get}
    
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
        if let nameLbl = self.nameLbl {
            nameLbl.text = user.name
        }
        if let emailLbl = self.emailLbl {
            emailLbl.text = user.email
        }
    }
}
