//
//  WTaskTableViewCell.swift
//  appTuukuul
//
//  Created by Ernesto Salazar on 9/3/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit

class WTaskTableViewCell: UITableViewCell {

    @IBOutlet var taskImg: UIImageView!
    @IBOutlet var taskNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskImg.circleImage()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
