//
//  FilterTableViewCell.swift
//  
//
//  Created by Kimaya Desai on 11/10/17.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

  
   
    @IBOutlet var cityme: UILabel!
    
    @IBOutlet var nickLabel: UILabel!
    @IBOutlet var yearLab: UILabel!
    
    @IBOutlet var stateLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
