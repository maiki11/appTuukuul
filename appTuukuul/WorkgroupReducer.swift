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
        var state = state ?? WorkgroupState(workgroups: [], status: .none)
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
        case let action as AddUserWorkgroupAction:
            if action.bid != nil {
                state.status = .loading
                addUser(of: action.bid, uid: action.uid)
            }
            break
        case let action as DeleteUserWorkgroupAction:
            if action.bid != nil {
                state.status = .loading
                deleteUser(of: action.bid, uid: action.uid)
            }
            break
        default:
            break
        }
        return state
    }
    
    func getUserWorkgroups(uid: String) -> Void {
        workgroupProvider.request(.getUserWorkgroups(uid: uid), completion: { result in
            switch(result){
            case .success(let response):
                print(response)
                do {
                    
                    let rep: NSDictionary = try response.mapJSON() as! NSDictionary
                    let array:NSArray = rep.value(forKey: "Datos") as! NSArray
                    let workgroups = Workgroup.from(array) ?? []
                    store.state.workgroupState.workgroups = workgroups
                    store.state.workgroupState.status = .none
                } catch MoyaError.jsonMapping(let error){
                    print("Error \(error)")
                } catch {
                    print("sabe")
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    /*func getEnterprise(id: Int) -> Void {
        if id == -1 {
            workgroupProvider.request(.getAll, completion: {
                result in
                switch result {
                case .success(let response):
                    do {
                        let repos : NSDictionary = try response.mapJSON() as! NSDictionary
                        let array : NSArray = repos.value(forKey: "enterprises") as! NSArray
                        
                        let enterprises = Business.from(array) ?? []
                        store.state.businessState.business = enterprises
                        store.state.businessState.status = .none
                    } catch MoyaError.jsonMapping(let error) {
                        print(error )
                    } catch {
                        print(":(")
                    }
                    
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            })
        }else{
            workgroupProvider.request(.get(id: id), completion: {
                result in
                switch result {
                case .success(let response):
                    do {
                        let repos : NSDictionary = try response.mapJSON() as! NSDictionary
                        let dic = repos.value(forKey: "enterprise") as! NSDictionary
                        let enterprise = Business.from(dic)
                        store.state.businessState.business.enumerated().forEach({
                            index, b in
                            if b.id == enterprise?.id {
                                store.state.businessState.business[index] = enterprise!
                                return
                            }else{
                                b.business.enumerated().forEach({
                                    i2, b2 in
                                    if b2.id == enterprise?.id {
                                        store.state.businessState.business[index].business[i2] = enterprise!
                                        return
                                    }
                                })
                            }
                        })
                        store.state.businessState.status = .none
                    } catch MoyaError.jsonMapping(let error) {
                        print(error )
                    } catch {
                        print(":(")
                    }
                    
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            })
        }
        
    }*/
    
    func addUser(of eid: Int, uid: Int) -> Void {
        workgroupProvider.request(.addUserAt(bid: eid, uid: uid), completion: {
            result in
            switch result {
            case .success(let response):
                if response.statusCode == 201 {
                    store.dispatch(GetWorkgroupAction(id: eid))
                    store.state.workgroupState.status = .finished
                    
                }else{
                    store.state.workgroupState.status = .failed
                }
                store.state.workgroupState.status = .none
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    
    func deleteUser(of eid: Int, uid: Int) -> Void {
        workgroupProvider.request(.deleteUser(eid: eid, uid: uid), completion: {
            result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    store.dispatch(GetWorkgroupAction(id: eid))
                    store.state.workgroupState.status = .finished
                    
                }else{
                    store.state.workgroupState.status = .failed
                }
                store.state.workgroupState.status = .none
                break
            case .failure(let error):
                print(error)
                break
            }
        })
    }
    
    
}
