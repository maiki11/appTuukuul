//
//  UserReducer.swift
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

var token = ""
var authPlugin = AccessTokenPlugin(token: token)
let userProvider = MoyaProvider<UserService>(plugins: [authPlugin])
let authProvider = MoyaProvider<AuthService>(plugins: [])
struct UserReducer: Reducer {
    func handleAction(action: Action, state: UserState? ) -> UserState {
        var state = state ?? UserState(user: nil, type: 1, users: [], status: .none)
        
        switch action {
        case let action as LogInAction:
            if action.email != nil {
                state.status = .loading
                login(with: action.email, password: action.password)
            }
            break
        case let action as GetUserAction:
            if action.uid != nil {
                state.status = .loading
                if action.uid == -1{
                    self.getUsers()
                }else{
                    self.getUser(by: action.uid)
                }
            }
            break
        case let action as ChangePassAction:
            if action.oldPass != nil {
                state.status = .loading
                changePass(old: action.oldPass, new: action.newPass)
            }
            break
        case _ as LogOutAction:
            self.logOut()
            state.status = .Finished("logout")
        default:
            break
        }
        return state
    }
    
    func login(with email: String, password: String ) -> Void {
        authProvider.request(.login(username: email, password: password), completion: { result in
            switch result {
            case .success(let response):
                do {
                    let repos : NSDictionary = try response.mapJSON() as! NSDictionary
                    if response.statusCode == 418  {
                        store.state.userState.status = .Failed("Email/Contraseña incorrecta!!")
                        return
                    }
                    //guard let t = repos.value(forKey: "token") as? String else{
                        //return
                    //}
                    //token = t
                    //authPlugin = AccessTokenPlugin(token: token)
                    if let userJson = repos.value(forKey: "Datos") as? NSDictionary {
                        //print("TOKEN:" ,token)
                        print(userJson)
                        let user  = User.from(userJson)
                        //print(user)
                        defaults.set(email, forKey: "email")
                        defaults.set(password, forKey: "password")
                        store.state.userState.user = user
                        store.state.userState.status = .Finished(User())
                        //store.dispatch(GetWorkgroupAction())
                        //store.dispatch(GetWeeksAction())
                    }
                   
                } catch MoyaError.jsonMapping(let error) {
                    print(error )
                    store.state.userState.status = .Failed("Email/Contraseña incorrecta!!")
                } catch {
                    print(":(")
                }
                break
            case .failure(let error):
                print(error)
                store.state.userState.status = .Failed(messages.errorG_Murmur)
                break
            }
            
        })
        
    }
    func changePass(old: String, new: String) -> Void {
        userProvider.request(.changePass(old: old, new: new), completion: { result in
            switch result {
            case .success(let response):
                do {
                     let repos : NSDictionary = try response.mapJSON() as! NSDictionary
                    print(repos)
                    if response.statusCode == 200 {
                        defaults.set(new, forKey: "password")
                        store.state.userState.status = .finished
                    }else if response.statusCode == 401{
                        store.state.userState.status = .Failed("Contraseña actual incorrecta")
                    }else if response.statusCode == 403 {
                         store.state.userState.status = .Failed("Hubo algun error")
                    }
                    
                    store.state.userState.status = .none

                } catch MoyaError.jsonMapping(let error) {
                    print(error )
                    store.state.userState.status = .Failed("Hubo algun error")
                } catch {
                    print(":(")
                }
                break
            case .failure(let error):
                print(error)
                store.state.userState.status = .Failed("Hubo algun error")
                store.state.userState.status = .none
                break
            }
            
        })
    }
    func getUser(by id: Int) -> Void {
        userProvider.request(.showUser(id: id), completion: {result in
            switch result {
                case .success(let response):
                    do {
                        let repos = try response.mapJSON() as! User
                        print(repos)
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
    func getUsers() -> Void {
        userProvider.request(.getAll(), completion: {result in
            switch result {
            case .success(let response):
                do {
                    let repos : NSDictionary = try response.mapJSON() as! NSDictionary
                    let array : NSArray = repos.value(forKey: "users") as! NSArray
                    let users = User.from(array) ?? []
                    store.state.userState.users = users
                    store.state.userState.status = .none
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
    func logOut() -> Void {
        UserDefaults().removeObject(forKey: "token")
        UserDefaults().removeObject(forKey: "email")
        UserDefaults().removeObject(forKey: "password")
    }
}

