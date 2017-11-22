//
//  WorkgroupService.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import Alamofire
import Moya
enum WorkgroupService {
    case getAll,
    get(id: Int),
    addUserAt(bid: Int, uid: Int),
    deleteUser(eid: Int, uid: Int),
    getUserWorkgroups(uid:String),
    getWorkgroupTasks(wid:String),
    getWorkgroupFiles(wid:String, fid:String),
    getWorkgroupPosts(wid:String, offset:Int),
    createPost(wid: String, uid: String, text: String)
    
}
extension WorkgroupService: TargetType, AccessTokenAuthorizable {
    var baseURL: URL { return URL(string: "\(Constants.ServerApi.url)")! }
    var path: String {
        switch self {
        case .get(let id):
            return"/\(id)"
        case .getAll:
            return ""
        case .addUserAt:
            return  "/AddUser"
        case .deleteUser(let eid, let uid):
            return "/\(eid)/\(uid)"
        case .getUserWorkgroups:
            return "/getWorkgroups"
        case .getWorkgroupTasks:
            return "/getWorkgroupTasks"
        case .getWorkgroupFiles:
            return "/getWorkgroupFiles"
        case .getWorkgroupPosts:
            return "/getWorkgroupPosts"
        case .createPost:
            return "/setPost"
        }
        
        
    }
    var method: Moya.Method {
        switch self {
        case .getAll, .get:
            return .get
        case .addUserAt, .getUserWorkgroups, .getWorkgroupTasks, .getWorkgroupFiles, .getWorkgroupPosts, .createPost:
            return .post
        case .deleteUser:
            return .delete
        }
    }
    var shouldAuthorize: Bool {
        switch self {
        case .getAll, .addUserAt, .deleteUser, .get, .getUserWorkgroups, .getWorkgroupTasks, .getWorkgroupFiles, .getWorkgroupPosts, .createPost:
            return true
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getAll, .deleteUser, .get:
            return nil
        case .addUserAt(let bid, let uid):
            return ["id_user": uid,
                    "id_enterprise": bid]
        case .getUserWorkgroups(let uid):
            return ["user":uid]
        case .getWorkgroupTasks(let wid):
            return ["workgroup":wid]
        case .getWorkgroupFiles(let wid, let fid):
            return ["workgroup":wid, "folder":fid]
        case .getWorkgroupPosts(let wid, let offset):
            return ["workgroup":wid, "offset": offset]
        case .createPost(let wid, let uid ,let text):
            return ["workgroup":wid, "user":uid, "post":text]
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getAll, .deleteUser, .get:
            return URLEncoding.default// Send parameters in URL for GET, DELETE and HEAD. For other HTTP methods, parameters will be sent in request body
        case .addUserAt, .getUserWorkgroups, .getWorkgroupTasks, .getWorkgroupFiles, .getWorkgroupPosts, .createPost:
            return JSONEncoding.default
        }
    }
    var sampleData: Data {
        switch self {
        case .getAll, .addUserAt, .deleteUser, .get, .getUserWorkgroups, .getWorkgroupTasks, .getWorkgroupFiles, .getWorkgroupPosts, .createPost:
            return "{ \"name\": \"Harry Potter\"}".utf8Encoded
        }
    }
    var task: Task {
        switch self {
        case .getAll, .addUserAt, .deleteUser, .get,.getUserWorkgroups, .getWorkgroupTasks, .getWorkgroupFiles, .getWorkgroupPosts, .createPost:
            return .request
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

