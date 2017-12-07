//
//  WorkgroupActions.swift
//  appTuukuul
//
//  Created by miguel reina on 20/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRecorder

let workgroupActionTypeMap: TypeMap = [GetWorkgroupAction.type: GetWorkgroupAction.self,
                                       GetUserWorkgroupsAction.type: GetUserWorkgroupsAction.self,
                                       AddUserWorkgroupAction.type :  AddUserWorkgroupAction.self,
                                       DeleteUserWorkgroupAction.type : DeleteUserWorkgroupAction.self,
                                       GetWorkgroupTasksAction.type: GetWorkgroupTasksAction.self,
                                       GetWorkgroupFilesAction.type: GetWorkgroupFilesAction.self,
                                       GetWorkgroupPostsAction.type: GetWorkgroupPostsAction.self,
                                       SetStatusWorkgroupTaskAction.type: SetStatusWorkgroupTaskAction.self
                                            ]

struct GetWorkgroupAction: StandardActionConvertible {
    static let type = "GET_WORKGROUP_ACTION"
    var id : Int!
    init(id: Int = -1) {
        self.id = id
    }
    init(_ standardAction: StandardAction) {
    }
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: GetWorkgroupAction.type, payload: [:], isTypedAction: true)
    }
}

struct GetUserWorkgroupsAction: StandardActionConvertible {
    static let type = "GET_USER_WORKGROUPS_ACTION"
    var uid: String!
    init(uid: String = ""){
        self.uid = uid
    }
    
    init(_ standardAction:StandardAction){}
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: GetUserWorkgroupsAction.type, payload: [:], isTypedAction: true)
    }
}

struct AddUserWorkgroupAction: StandardActionConvertible {
    static let type = "ADD_USER_WORKGROUP_ACTION"
    var uid:Int!
    var bid:Int!
    init(uid: Int, bid: Int) {
        self.uid = uid
        self.bid = bid
    }
    init(_ standardAction: StandardAction) {
    }
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: AddUserWorkgroupAction.type, payload: [:], isTypedAction: true)
    }
}

struct DeleteUserWorkgroupAction: StandardActionConvertible {
    static let type = "DELETE_USER_WORKGROUP_ACTION"
    var uid:Int!
    var bid:Int!
    init(uid: Int, bid: Int) {
        self.uid = uid
        self.bid = bid
    }
    init(_ standardAction: StandardAction) {
    }
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: DeleteUserWorkgroupAction.type, payload: [:], isTypedAction: true)
    }
}

struct GetWorkgroupTasksAction: StandardActionConvertible {
    static let type = "GET_WORKGROUP_TASKS_ACTION"
    var wid:String!
    init(wid: String) {
        self.wid = wid
    }
    init(_ standardAction: StandardAction) {
    }
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: GetWorkgroupTasksAction.type, payload: [:], isTypedAction: true)
    }
}

struct SetStatusWorkgroupTaskAction: StandardActionConvertible{
    static let type = "SET_STATUS_WORKGROUP_TASK_ACTION"
    var id:String!
    init(id: String) {
        self.id = id
    }
    init(_ standardAction: StandardAction) {
    }
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: SetStatusWorkgroupTaskAction.type, payload: [:], isTypedAction: true)
    }
}

struct GetWorkgroupFilesAction: StandardActionConvertible {
    static let type = "GET_WORKGROUP_FILES_ACTION"
    var wid: String!
    var fid: String!
    init(wid:String, fid: String){
        self.wid = wid
        self.fid = fid
    }
    
    init(_ standarAction: StandardAction){}
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: GetWorkgroupFilesAction.type, payload: [:], isTypedAction: true)
    }
}

struct GetWorkgroupPostsAction: StandardActionConvertible {
    static let type = "GET_WORKGROUP_POST_ACTION"
    var wid:String!
    var offset:Int!
    init(wid:String, offset: Int){
        self.wid = wid;
        self.offset = offset
    }
    init(_ standarAction: StandardAction){}
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: GetWorkgroupPostsAction.type, payload: [:], isTypedAction: true)
    }
}

struct CreatePostAction: StandardActionConvertible {
    static let type = "CREATE_POST_ACTION"
    var uid: String!
    var wid: String!
    var text: String!
    init(uid: String, wid: String, text: String){
        self.text = text
        self.uid = uid
        self.wid = wid
    }
    init(_ standarAction: StandardAction){}
    
    func toStandardAction() -> StandardAction {
        return StandardAction(type: CreatePostAction.type, payload: [:], isTypedAction: true)
    }
}


