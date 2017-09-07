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
    static let kInterests = "interests"
    
    
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
    var interests: [String] = []
    
    init(){
    }
    
    init(map: Mapper) throws {
        try self.id = map.from("id")
        self.email = map.optionalFrom(User.kEmail)
        self.name = map.optionalFrom(User.kName)
        self.fullname = map.optionalFrom(User.kFullName)
        self.lastname = map.optionalFrom(User.kLastName)
        self.img = map.optionalFrom(User.kImg)
        self.cover = map.optionalFrom(User.kCover)
        self.occupation = map.optionalFrom(User.kOccupation)
        self.birthday = map.optionalFrom(User.kBirthday)
        self.gender = map.optionalFrom(User.kGender)
        self.cellphone = map.optionalFrom(User.kCellphone)
        try self.interests = map.from(User.kInterests)
    }
    
    func toDictionary() -> NSDictionary {
        return [User.kEmail: self.email ?? "",
                User.kName: self.name ?? "",
                User.kLastName: self.lastname ?? ""
        ]
    }
    
}
protocol UserBindible: AnyObject {
    var user: User! {get set}
    var nameLbl: UILabel! {get}
    var emailLbl: UILabel! {get}
    var lastnameLbl: UILabel! {get}
    //var interestsLbl: UILabel! {get}
    
}
extension UserBindible {
    var nameLbl: UILabel! {return nil}
    var emailLbl: UILabel! {return nil}
    var lastnameLbl: UILabel! {return nil}
    //var interestsLbl: UILabel! {return nil}
    
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
        if let lastnameLbl = self.lastnameLbl {
            lastnameLbl.text = user.lastname
        }
        if let emailLbl = self.emailLbl {
            emailLbl.text = user.email
        }
        /*if let interestsLbl = self.interestsLbl {
            interestsLbl.text = user.interests
        }*/
    }
}
