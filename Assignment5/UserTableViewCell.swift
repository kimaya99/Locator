//
//  UserTableViewCell.swift
//  Assignment5
//
//  Created by Kimaya Desai on 11/10/17.
//  Copyright © 2017 SDSU. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet var sampleLabel: UILabel!
    @IBOutlet var state: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var yearC: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
