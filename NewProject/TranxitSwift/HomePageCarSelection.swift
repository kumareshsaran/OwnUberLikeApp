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
    
    @IBOutlet weak var buttonRideNow: UIButton!
    @IBOutlet weak var buttonSchudule: UIButton!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    var onClickRideNow : (()->())?
    var onClickschedule : (()->())?
    var selectedIndex = -1
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.CollectionViewCarSelection.delegate = self
        self.CollectionViewCarSelection.dataSource = self
        
        self.CollectionViewCarSelection.register( UINib(nibName: CarSelectionCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CarSelectionCollectionViewCell.identifier)
        
        localize()
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 15
    }
 
    
    @IBAction func RideNowAction(_ sender: Any) {
        self.onClickRideNow?()
    }
    
    @IBAction func schuduleSction(_ sender: Any) {
        self.onClickschedule?()
    }
    
    private func localize(){
        self.buttonRideNow.setTitle(Constants.string.rideNow.localize(), for: .normal)
        self.buttonSchudule.setTitle(Constants.string.scheduleRide.localize(), for: .normal)
    }
    
}

extension HomePageCarSelection : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarSelectionCollectionViewCell.identifier, for: indexPath) as! CarSelectionCollectionViewCell
        cell.ImageCar.image = self.selectedIndex == indexPath.row ? #imageLiteral(resourceName: "ic_micro_selected") : #imageLiteral(resourceName: "ic_micro")
        
        
            cell.labelETABottomConstaint.constant = self.selectedIndex == indexPath.row ? self.frame.height / 40 : 0
            cell.labelCarNameTopContraint.constant = self.selectedIndex == indexPath.row ? self.frame.height / 40 : 0
        
        cell.labelETATime.text = "5 Min"
        cell.labelCarName.text = "Auto"
        
        print(self.frame.height / 50)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4 , height: self.frame.height / 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.CollectionViewCarSelection.reloadData()
    }
    
    
}
