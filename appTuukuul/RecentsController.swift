//
//  RecentsController.swift
//  appTuukuul
//
//  Created by miguel reina on 26/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit
import Foundation
 
class RecentsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navCon.styleN
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let navCon = navigationController
        navCon?.styleNavBar()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1098039216, green: 0.137254902, blue: 0.1921568627, alpha: 1)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.navigationItem.title = "Recientes"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
