//
//  HomePageCarSelection.swift
//  User
//
//  Created by CSS on 31/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class HomePageCarSelection: UIView {

    @IBOutlet weak var CollectionViewCarSelection: UICollectionView!
    
    @IBOutlet weak var imageSearch: UIImageView!
    
    @IBOutlet weak var labelWhereAreYouGoing: UILabel!
    @IBOutlet weak var labelNiceToSeeYou: UILabel!
    @IBOutlet weak var labelSearchDestination: UILabel!
    
    @IBOutlet weak var viewSearchLocation: UIView!

    // An empty implementation adversely affects performance during animation.
    var onClickSearchLocation : (()->())?

    var selectedIndex = -1
    override func draw(_ rect: CGRect) {
        localize()
        
    }
    
    override func layoutSubviews() {
       // self.layer.cornerRadius = 15
        self.addShadow()
        initialLoad()
    }
 
    private func localize(){
        self.labelNiceToSeeYou.text = Constants.string.niceToMeetYou.localize()
        self.labelWhereAreYouGoing.text = Constants.string.whereAreYouGoing.localize()
        self.labelSearchDestination.text = Constants.string.searchYourDestination.localize()
    }
    
    private func initialLoad(){
        self.viewSearchLocation.isUserInteractionEnabled = true
        self.viewSearchLocation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewSearchAction(sender:))))
        
        
    }
    
    @objc  func viewSearchAction(sender: UIGestureRecognizer){
        self.onClickSearchLocation?()
    }
    
}

