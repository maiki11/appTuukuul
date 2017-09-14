//
//  ProfileController.swift
//  appTuukuul
//
//  Created by miguel reina on 26/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit
import ReSwift

class ProfileController: UIViewController{
    var user: User!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet weak var filesBtn: UIButton!
    @IBOutlet weak var publishBtn: UIButton!
    @IBOutlet weak var articlesBtn: UIButton!
    @IBOutlet weak var viewBtn: UIView!
    @IBOutlet weak var dataInfo: UITableView!
    let sections: [String] = ["Datos","Intereses","Configuraciones"]
    let imgSections: [UIImageView] = [UIImageView(image: #imageLiteral(resourceName: "user-3x-white")), UIImageView(image: #imageLiteral(resourceName: "tags")), UIImageView(image: #imageLiteral(resourceName: "settings"))]
    var personalData = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataInfo.delegate = self
        dataInfo.dataSource = self
        user = store.state.userState.user
        self.personalData.append(["email":user.email!])
        self.personalData.append(["birthday":user.birthday!])
        self.personalData.append(["gender":user.gender!])
        self.personalData.append( ["occupation":user.occupation!])
        self.personalData.append(["cellphone": user.cellphone!])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.user = store.state.userState.user
        //self.bind()
        
        store.subscribe(self){
            state in
            state.userState
        }
        let navCon = navigationController
        navCon?.styleNavBar()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1098039216, green: 0.137254902, blue: 0.1921568627, alpha: 1)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.navigationItem.title = "Perfil"
        self.usernameLbl.text = store.state.userState.user.fullname
        guard let coverURL = URL(string: Constants.ServerApi.filesurl+store.state.userState.user.cover!) else { return }
        guard let profileURL = URL(string: Constants.ServerApi.filesurl+store.state.userState.user.img!) else { return }
        self.loadImage(url: coverURL, context: self.coverImg)
        self.loadImage(url: profileURL, context: self.profileImage)
        profileImage.profileUser()
        msgBtn.profileUser()
        filesBtn.profileUser()
        publishBtn.profileUser()
        articlesBtn.profileUser()
        self.viewBtn.addBottomBorderWithColor(color: #colorLiteral(red: 0.337254902, green: 0.7058823529, blue: 0.631372549, alpha: 1), width: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImage(url: URL, context: UIImageView){
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    if let imageData = data {
                        context.image = UIImage(data: imageData)
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        downloadPicTask.resume()
    }
    
    @IBAction func logout(_ sender: Any) {
        store.dispatch(LogOutAction())
    }
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource{

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return self.personalData.count
        }
        if(section == 1){
            if(user.interests.isEmpty == false){
                return (user.interests.count)
                
            }else{
                return 1
            }
            
        }
        if(section==2){
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30)
        let footerView = UIView(frame:rect)
        footerView.backgroundColor = #colorLiteral(red: 0.08339247853, green: 0.1178589687, blue: 0.1773400605, alpha: 1)
        let img = imgSections[section]
        img.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        footerView.addSubview(img)
        let title = UILabel()
        title.text = sections[section]
        title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        title.frame = CGRect(x: 30, y: 5, width: tableView.frame.size.width - 20, height: 20)
        footerView.addSubview(title)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellLogout")
            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonalDataTableViewCell
            if(indexPath.section == 0) {
                let info = self.personalData[indexPath.row]
                for(k,v) in info{
                    cell.title.text = k.uppercased()
                    cell.data.text = v
                }
            }else{
                if(user.interests.isEmpty==false){
                    let info = self.user.interests[indexPath.row]
                    cell.title.text = info.uppercased()
                    cell.data.text = ""
                }
            }
            return cell
        }
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "infoSegue", sender:1)
    }*/
}

extension ProfileController: StoreSubscriber{
    typealias StoreSubscriberStateType = UserState
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
    
    func newState(state: UserState) {
        
        switch state.status {
        case .Finished(let s as String):
            if s == "logout"{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "main") as UIViewController
                present(vc, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
}
