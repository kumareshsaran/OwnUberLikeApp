//
//  AddCardTableViewCell.swift
//  User
//
//  Created by CSS on 12/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class AddCardTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textFiledCardNumber: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelTitle.text = "Card number"
        textFiledCardNumber.becomeFirstResponder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
