//
//  ProfileController.swift
//  appTuukuul
//
//  Created by miguel reina on 26/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit
import ReSwift
import Foundation

class ProfileController: UIViewController{
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet weak var filesBtn: UIButton!
    @IBOutlet weak var publishBtn: UIButton!
    @IBOutlet weak var articlesBtn: UIButton!
    @IBOutlet weak var viewBtn: UIView!
    @IBOutlet weak var dataInfo: UITableView!
    let sections: [String] = ["Datos","Intereses"]
    var personalData = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataInfo.delegate = self as? UITableViewDelegate
        dataInfo.dataSource = self as? UITableViewDataSource
        self.personalData.append(["email":store.state.userState.user.email!])
        self.personalData.append(["birthday":store.state.userState.user.birthday!])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navCon = navigationController
        navCon?.styleNavBar()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1098039216, green: 0.137254902, blue: 0.1921568627, alpha: 1)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.navigationItem.title = "Perfil"
        self.usernameLbl.text = store.state.userState.user.fullname
        //let url = URL(fileURLWithPath: store.state.userState.user.cover!)
        //let data = try? Data(contentsOf: url)
        //self.coverImg = UIImage(data: data!)
        
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
    
    
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return self.personalData.count
        }
        //if section == 1{
            return 2
        //}
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    /*func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let view = UIView()
        view.tintColor = #colorLiteral(red: 0.08339247853, green: 0.1178589687, blue: 0.1773400605, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.08339247853, green: 0.1178589687, blue: 0.1773400605, alpha: 1)
        let myCustomView = UIImageView(frame: CGRect(x: 5, y: 19, width: 40, height: 12))
        myCustomView.image = #imageLiteral(resourceName: "bullet")
        view.addSubview(myCustomView)
        let lbl = UILabel()
        lbl.text = sections[section]
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.frame = CGRect(x: 50, y: 16, width: Int(self.view.frame.width - 35), height: 20)
        view.addSubview(lbl)
        
        return view
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonalDataTableViewCell
        if(indexPath.section == 0) {
            let info = self.personalData[indexPath.row]
            for(k,v) in info{
                cell.title.text = k
                cell.data.text = v
            }
            
        }
        
        //cell.textLabel?.text = "Semana"
        /*cell.detailTextLabel?.text = (Date(string:w.startDate, formatter: .yearMonthAndDay)?.string(with: .dayMonthAndYear3))! + " al " + (Date(string:w.endDate, formatter: .yearMonthAndDay)?.string(with: .dayMonthAndYear2))!
         */
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "infoSegue", sender:1)
    }
}
