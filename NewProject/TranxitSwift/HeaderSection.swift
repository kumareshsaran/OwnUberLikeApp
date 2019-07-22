//
//  HeaderSection.swift
//  User
//
//  Created by CSS on 25/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class HeaderSection: UIView {
    let labelTitle = UILabel()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.backgroundColor = .white
        self.addSubview(self.labelTitle)
        self.labelTitle.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([self.labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),self.labelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),self.labelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)])
        self.labelTitle.textColor = UIColor.lightGray
        
        Common.setFont(to: labelTitle, isTitle: false, size: 10)
      
    }
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    
        
    }

    
    func setTitle(title: String){
        self.labelTitle.text = title
    }

}
