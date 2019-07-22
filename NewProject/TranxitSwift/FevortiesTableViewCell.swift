//
//  FevortiesTableViewCell.swift
//  User
//
//  Created by CSS on 28/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class FevortiesTableViewCell: UITableViewCell {

    @IBOutlet weak var labelAddressTitle: UILabel!
    @IBOutlet weak var imageVIewFev: UIImageView!
    @IBOutlet weak var labelAddessValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFevData(title: String, addressValue : String, titleImage: UIImage){
        self.labelAddressTitle.text = title
        self.labelAddessValue.text = addressValue
        self.imageVIewFev.image = titleImage
    }
    
}
