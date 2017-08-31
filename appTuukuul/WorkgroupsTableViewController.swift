//
//  WorkgroupsTableViewController.swift
//  appTuukuul
//
//  Created by Developer on 8/30/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit
import ReSwift

class WorkgroupsTableViewController: UITableViewController {

    var workgroups:[Workgroup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var w = Workgroup()
        w.name = "co.tech"
        w.img = "https://firebasestorage.googleapis.com/v0/b/familyoffice-6017a.appspot.com/o/users%2Fc5bsp7Lgq4aYh5PG5uBXGcn7nJz2%2Fsafebox%2Fco.tech_small.png?alt=media&token=5c855d31-0e5f-49bd-a389-5c377b5f9d1c"
        
        workgroups.append(w)
        
        w.name = "fox"
        w.img = "https://firebasestorage.googleapis.com/v0/b/familyoffice-6017a.appspot.com/o/users%2Fc5bsp7Lgq4aYh5PG5uBXGcn7nJz2%2Fsafebox%2Ffox_small.png?alt=media&token=a868e1c1-a236-48d3-9165-b60de670580e"
        workgroups.append(w)
        
        let navCon = navigationController
        navCon?.styleNavBar()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1098039216, green: 0.137254902, blue: 0.1921568627, alpha: 1)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.navigationItem.title = "Grupos de Trabajo"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(self.handleNew))
    }
    
    func handleNew() -> Void{
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.workgroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workgroupCell", for: indexPath) as! WorkgroupTableViewCell
        
        let workgroup = self.workgroups[indexPath.row]
        
        cell.nameLbl.text = workgroup.name
        cell.imgUIImage.loadImage(urlString: workgroup.img!)
        
        return cell
    }
 

}

//extension WorkgroupsTableViewController: StoreSubscriber {
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        
//        store.subscribe(self) {
//            state in
//            state.workgroupState
//        }
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        store.unsubscribe(self)
//    }
//    
//    func newState(state: WorkgroupState) {
//        
//    }
//}
