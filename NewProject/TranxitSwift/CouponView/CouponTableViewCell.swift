//
//  CouponTableViewCell.swift
//  User
//
//  Created by CSS on 08/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class CouponTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewCoupon: UIImageView!
    @IBOutlet weak var labelCouponTitle: UILabel!
    @IBOutlet weak var labelCouponDiscription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
