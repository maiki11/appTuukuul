//
//  InterestsTableViewCell.swift
//  appTuukuul
//
//  Created by miguel reina on 30/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit

class InterestsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
