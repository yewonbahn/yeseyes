//
//  ItemCell.swift
//  YES_EYES
//
//  Created by Moon on 2021/08/02.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
