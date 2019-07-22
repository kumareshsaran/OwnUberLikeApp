//
//  PaymentTableViewCell.swift
//  User
//
//  Created by CSS on 15/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePaymentType: UIImageView!
    @IBOutlet weak var labelPaymentType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
