//
//  WorkgroupTasksViewController.swift
//  appTuukuul
//
//  Created by Developer on 9/1/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit
import ReSwift
import XLPagerTabStrip

class WorkgroupTasksViewController: UIViewController {
    var tasks:[WorkgroupTask] = []

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskDetails"{
            let vc = segue.destination as! TaskDetailsViewController
            vc.task = sender as! WorkgroupTask
        }
    }

}

extension WorkgroupTasksViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Tareas")
    }
}

extension WorkgroupTasksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "taskCell_ID") as! WTaskTableViewCell
        
        
        let task = self.tasks[indexPath.row]
        cell.task = task
        cell.taskNameLbl.text = task.name!
        cell.taskImg.loadImage(urlString: "\(Constants.ServerApi.filesurl)\(task.img!)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let terminateAction = UITableViewRowAction(style: .normal, title: "Terminar") { (action, indexPath) in
            let task = self.tasks[indexPath.row]
        }
        let editAction = UITableViewRowAction(style: .normal, title: "Editar") { (action, indexPath) in
            let task = self.tasks[indexPath.row]
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
            let task = self.tasks[indexPath.row]
        }
        return [deleteAction, editAction, terminateAction]
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "taskDetails", sender: self.tasks[indexPath.row])
    }
    
}

extension WorkgroupTasksViewController: StoreSubscriber {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        store.dispatch(GetWorkgroupTasksAction(wid: store.state.workgroupState.workgroup.id!))
        store.subscribe(self) {
            state in
            state.workgroupState
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Tareas", style: .plain, target: nil, action: nil)
    }
    
    func newState(state: WorkgroupState) {
        self.tasks = store.state.workgroupState.tasks
        self.tableView.reloadData()
    }
    
    

}
