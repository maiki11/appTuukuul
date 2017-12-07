//
//  WTaskTableViewCell.swift
//  appTuukuul
//
//  Created by Ernesto Salazar on 9/3/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit

class WTaskTableViewCell: UITableViewCell {
    var task :WorkgroupTask!
    @IBOutlet var taskImg: UIImageView!
    @IBOutlet var taskNameLbl: UILabel!
    @IBOutlet weak var completeTask: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskImg.circleImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func handleDidChange(_ sender: UISwitch) {
        print("hola")
        print("TASK",task)
        store.dispatch(SetStatusWorkgroupTaskAction(id: task.id!))
        print("adios")
    }
}
