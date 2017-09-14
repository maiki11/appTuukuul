//
//  PersonalDataTableViewCell.swift
//  appTuukuul
//
//  Created by miguel reina on 31/08/17.
//  Copyright © 2017 tuukuul. All rights reserved.
//

import UIKit

class PersonalDataTableViewCell: UITableViewCell{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var data: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
