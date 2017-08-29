//
//  NavigationController.swift
//  appTuukuul
//
//  Created by miguel reina on 26/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController{
    func styleNavBar(){
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1215686275, green: 0.6901960784, blue: 0.9882352941, alpha: 1)
        self.tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0.1098039216, green: 0.137254902, blue: 0.1921568627, alpha: 1)
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
