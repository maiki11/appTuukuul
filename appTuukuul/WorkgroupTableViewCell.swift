//
//  WorkgroupTableViewCell.swift
//  appTuukuul
//
//  Created by Ernesto Jaramillo on 8/30/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit

class WorkgroupTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUIImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUIImage.circleImage()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
