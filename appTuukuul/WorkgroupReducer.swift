//
//  WorkgroupReducer.swift
//  appTuukuul
//
//  Created by miguel reina on 19/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//
import Foundation
import ReSwift
import Alamofire
import Moya
import Mapper
let workgroupProvider = MoyaProvider<WorkgroupService>(plugins: [authPlugin])

struct WorkgroupReducer: Reducer {
    func handleAction(action: Action, state: WorkgroupState?) -> WorkgroupState {
        var state = state ?? WorkgroupState(workgroups: [], workgroup:nil, status: .none, tasks: [], files: [], posts: [])
        switch action {
        case let action as GetUserWorkgroupsAction:
            if action.uid != "" {
                state.status = .loading
                getUserWorkgroups(uid: action.uid)
            }
            break
        /*case is GetWeeksAction:
            if !token.isEmpty {
                state.status = .loading
            }
            break*/
//        case let action as AddUserWorkgroupAction:
//            if action.bid != nil {
//                state.status = .loading
//                addUser(of: action.bid, uid: action.uid)
//            }
//            break
//        case let action as DeleteUserWorkgroupAction:
//            if action.bid != nil {
//                state.status = .loading
//                deleteUser(of: action.bid, uid: action.uid)
//            }
//            break
        case let action as GetWorkgroupTasksAction:
            if action.wid != nil{
                state.status = .loading
                getWorkgroupTasks(wid: action.wid)
            }
            break
        case let action as GetWorkgroupFilesAction:
            if action.wid != nil && action.fid != nil{
                state.status = .loading
                getWorkgroupFiles(wid: action.wid, fid: action.fid)
            }
            break
        case let action as GetWorkgroupPostsAction:
            if action.wid != nil && action.offset != nil{
                state.status = .loading
                getWorkgroupPosts(wid: action.wid, offset: action.offset)
            }
            break
        case let action as CreatePostAction:
            if action.wid != nil && action.uid != nil && action.text != nil {
                state.status = .loading
                createPost(wid: action.wid, uid: action.uid, text: action.text)
            }
        default:
            break
        }
        return state
    }
    
    func getUserWorkgroups(uid: String) -> Void {
        workgroupProvider.request(.getUserWorkgroups(uid: uid), completion: { result in
            switch(result){
            case .success(let response):
                do {
                    
                    let rep: NSDictionary = try response.mapJSON() as! NSDictionary
                    let array:NSArray = rep.value(forKey: "Datos") as! NSArray
                    let workgroups = Workgroup.from(array) ?? []
                    store.state.workgroupState.workgroups = workgroups
                    store.state.workgroupState.status = .none
                } catch MoyaError.jsonMapping(let error){
                    print("Error \(error)")
                } catch {
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    func getWorkgroupTasks(wid: String) -> Void {
        workgroupProvider.request(.getWorkgroupTasks(wid: wid), completion: { result in
            switch(result){
            case .success(let response):
                do{
                    let rep: NSDictionary = try response.mapJSON() as! NSDictionary
                    if rep.value(forKey: "Estado") as! Int == 0{
                        print("No hay tareas") //Cómo mostrar en vista?? state???
                    }else{
                        let array:NSArray = rep.value(forKey: "Datos") as! NSArray
                        let tasks = WorkgroupTask.from(array) ?? []
                        store.state.workgroupState.tasks = tasks
                        store.state.workgroupState.status = .none
                    }
                } catch MoyaError.jsonMapping(let error){
                    print("error: \(error)")
                } catch {
                    print("Error")
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    func getWorkgroupFiles(wid: String, fid:String) -> Void {
        workgroupProvider.request(.getWorkgroupFiles(wid: wid, fid: fid), completion: { result in
            switch(result){
            case .success(let response):
                do{
                    let rep: NSDictionary = try response.mapJSON() as! NSDictionary
                    let data: NSDictionary = rep.value(forKey: "Datos") as! NSDictionary
                    let folders:NSArray = data.value(forKey: "Folders") as! NSArray
                    let files:NSArray = data.value(forKey: "Files") as! NSArray
                    let wFolders = WorkgroupFile.from(folders) ?? []
                    let wFiles = WorkgroupFile.from(files) ?? []
                    var wBackFolder = [WorkgroupFile()]
                    wBackFolder[0].name = ".."
                    store.state.workgroupState.files = wBackFolder + wFolders + wFiles
                    store.state.workgroupState.status = .finished
                    
                } catch MoyaError.jsonMapping(let error){
                    print("error: \(error)")
                } catch {
                    print("error")
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    func createPost(wid: String, uid: String, text: String) -> Void {
        print("Creating post")
        workgroupProvider.request(.createPost(wid: wid, uid: uid, text: text), completion: {result in
            switch(result) {
            case .success(let response):
                print(response)
                // El response debería traer una atributo con todo el post ya listo y así lo agrego al state como la última línea comentada.
//                var post = WorkgroupPost()
//                post.post = text
//                post.user = uid
//                post.fileType = "text"
//                store.state.workgroupState.posts = store.state.workgroupState.posts + [post]
                store.state.workgroupState.status = .finished
            case .failure(let error):
            print(error)
            break
            }
        })
    }
    
    func getWorkgroupPosts(wid:String, offset:Int) -> Void{
        workgroupProvider.request(.getWorkgroupPosts(wid: wid, offset: offset), completion: {result in
            switch(result){
            case .success(let response):
                do{
                    let rep: NSDictionary = try response.mapJSON() as! NSDictionary
                    let estado: Int = rep.value(forKey: "Estado") as! Int
                    if(estado==1){
                        let data: NSArray = rep.value(forKey: "Datos") as! NSArray
                        let posts = WorkgroupPost.from(data) ?? []
                        
                        posts.forEach({ (w) in
                            store.state.workgroupState.posts.insert(w, at: 0)
                        })
                        store.state.workgroupState.status = .finished
                    }
                    
                } catch MoyaError.jsonMapping(let error){
                    print("error: \(error)")
                } catch {
                    print("error")
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    
}
