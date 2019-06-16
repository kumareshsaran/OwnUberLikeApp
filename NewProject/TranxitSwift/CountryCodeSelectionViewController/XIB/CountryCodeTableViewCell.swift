//
//  CountryCodeTableViewCell.swift
//  User
//
//  Created by CSS on 09/06/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class CountryCodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelCountryCode: UILabel!
    
    @IBOutlet weak var imageCountry: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setdata(data: Country){
        self.labelCountryCode.text = "\(data.name)" + "(\(data.dial_code))"
        self.imageCountry.image = UIImage(named: "CountryPicker.bundle/"+data.code)
    }
    
}

