//
//  PostMineTableViewCell.swift
//  appTuukuul
//
//  Created by Ernesto Salazar on 9/13/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit

class PostMineTableViewCell: UITableViewCell {

    @IBOutlet var userImg: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
