//
//  HomePageViewController+LoadExternalView.swift
//  User
//
//  Created by CSS on 31/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import  UIKit

extension HomePageViewController {
    
    func loadCarSelectionView() {//MARK:- load car category selection view
        if let carSelection = Bundle.main.loadNibNamed(XIB.Names.HomePageCarSelection, owner: self, options: nil),
            self.ViewCarSelection == nil  {
            
            self.ViewCarSelection = carSelection.first as? HomePageCarSelection
            self.view.addSubview(self.ViewCarSelection!)
            
            self.ViewCarSelection?.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                (self.ViewCarSelection?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))!,
                (self.ViewCarSelection?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))!,
                (self.ViewCarSelection?.heightAnchor.constraint(equalToConstant: (self.ViewCarSelection?.frame.height)!))!,
                (self.ViewCarSelection?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0))!,
                ])
          //  self.view.addSubview(self.ViewCarSelection!)
            
            self.ViewCarSelection?.layer.cornerRadius = 15
            self.ViewCarSelection?.onClickSearchLocation = {
             //   self.present(id: Storyboard.Ids.LocationSearchTableViewController, animation: true,presentationStyle: .popover)
                self.loadRideNowDetailView()
            }
            
        }else{
            print("View Not loaded")
        }
        
    }
    
    func loadRideNowDetailView(){  //MARK:- Show RideNow View
        if let rideNowDetail = Bundle.main.loadNibNamed(XIB.Names.RideNowDetailViwe, owner: self, options: nil),
            self.rideNowDetailView == nil  {
            
            self.rideNowDetailView = rideNowDetail.first as? RideNowDetailView
            
            self.view.addSubview(self.rideNowDetailView!)
            
            self.rideNowDetailView?.translatesAutoresizingMaskIntoConstraints = false
            self.rideNowDetailView?.showAnimateView(self.rideNowDetailView!, isShow: true, direction: .bottom)
            self.view.bringSubview(toFront: self.rideNowDetailView!)
            
            NSLayoutConstraint.activate([(
                    self.rideNowDetailView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0))!,(self.rideNowDetailView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0))!,(self.rideNowDetailView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0))!,])
            
          self.rideNowDetailView?.heightAnchor.constraint(equalToConstant: (self.view?.frame.height ?? 0.0 ) - 180 ).isActive = true

            if #available(iOS 13.0, *) {
                        self.rideNowDetailView?.backgroundColor = .systemBackground
                    } else {
                        // Fallback on earlier versions
                    }
        }
        
        self.rideNowDetailView?.viewMainHeight = self.view
        self.rideNowDetailView?.rideNowHeightConstrait = (self.rideNowDetailView?.heightAnchor.constraint(equalToConstant: (self.view?.frame.height ?? 0.0 ) - 180))!
        

        self.rideNowDetailView?.onClickCancel = { [weak  self] in
                self?.isShowFareDetailView = false
        }
        
        self.rideNowDetailView?.onClickSourceAddress = { [weak self] in
            let navigation = UINavigationController(rootViewController: LocationSearchTableViewController())
            self?.presentWithClass(viewController: navigation)
            
        }
        
        self.rideNowDetailView?.onClickDestinationAddress = { [weak self] in
            let navigation = UINavigationController(rootViewController: LocationSearchTableViewController())
            self?.presentWithClass(viewController: navigation)
        }
        
        self.rideNowDetailView?.onClickPayment = { [weak self] in
            if  let payment = self?.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.PaymentViewController) as? PaymentViewController {
                let nav = UINavigationController(rootViewController: payment)
                self?.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func removeRideNowDetailView(){ //MARK:- remove ride  now detail view
        self.rideNowDetailView?.showAnimateView(self.rideNowDetailView!, isShow: false, direction: .top)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.rideNowDetailView?.dismissView(onCompletion: {
                self.rideNowDetailView = nil
            })
        }
    }
}
