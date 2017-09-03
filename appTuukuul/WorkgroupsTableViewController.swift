//
//  WorkgroupsTableViewController.swift
//  appTuukuul
//
//  Created by Ernesto Jaramillo on 8/30/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit
import ReSwift

class WorkgroupsTableViewController: UITableViewController {

    var workgroups:[Workgroup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navCon = navigationController
        navCon?.styleNavBar()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1098039216, green: 0.137254902, blue: 0.1921568627, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.navigationItem.title = "Grupos de Trabajo"
        
        self.navigationController?.navigationBar.backItem?.title = ""
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "workgroupSegue", sender: self.workgroups[indexPath.row])
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workgroupCell", for: indexPath) as! WorkgroupTableViewCell
        
        let workgroup = self.workgroups[indexPath.row]
        
        cell.nameLbl.text = workgroup.name
        print(workgroup.img!)
        cell.imgUIImage.loadImage(urlString: "\(Constants.ServerApi.filesurl)\(workgroup.img!)")
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "workgroupSegue"{
            let vc = segue.destination as! WorkgroupDetailsViewController
            vc.workgroup = sender as! Workgroup
        }
        
    }

}

extension WorkgroupsTableViewController: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        store.dispatch(GetUserWorkgroupsAction(uid: store.state.userState.user.id!))
        
        store.subscribe(self) {
            state in
            state.workgroupState
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func newState(state: WorkgroupState) {
        self.workgroups = store.state.workgroupState.workgroups
        self.tableView.reloadData()
    }
}
