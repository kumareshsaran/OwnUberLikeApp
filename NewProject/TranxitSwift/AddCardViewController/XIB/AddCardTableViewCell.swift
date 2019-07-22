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
        
        textFiledCardNumber.becomeFirstResponder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(indexPath : IndexPath){
        switch indexPath.row {
        case 0:
            labelTitle.text = "Card number"
        case 1:
            labelTitle.text = "Exp. date"
        case 2:
            labelTitle.text = "Cvv"
        default:
            print("")
        }
        
    }
    
}
