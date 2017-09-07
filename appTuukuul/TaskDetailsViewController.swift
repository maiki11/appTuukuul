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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
