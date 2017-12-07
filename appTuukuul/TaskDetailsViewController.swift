//
//  TaskDetailsViewController.swift
//  appTuukuul
//
//  Created by Ernesto Salazar on 9/6/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    @IBOutlet var tTitleLbl: UILabel!
    @IBOutlet var tDescTextArea: UITextView!
    
    var task:WorkgroupTask!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tTitleLbl.text = task.name!
        tDescTextArea.text = task.description!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
