//
//  CarSelectionCollectionViewCell.swift
//  User
//
//  Created by CSS on 31/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class CarSelectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImageCar: UIImageView!
    
    @IBOutlet weak var labelCarName: UILabel!
    @IBOutlet weak var labelETABottomConstaint: NSLayoutConstraint!
    @IBOutlet weak var labelETATime: UILabel!
    @IBOutlet weak var labelCarNameTopContraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ImageCar.makeRoundedCorner()
    }
    
    override class var identifier: String {
        return XIB.Names.CarSelectionCollectionViewCell
    }

}
