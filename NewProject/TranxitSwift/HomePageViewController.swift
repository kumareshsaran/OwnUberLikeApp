//
//  HomePageViewController.swift
//  User
//
//  Created by CSS on 31/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import GoogleMaps

import KWDrawerController


class HomePageViewController: UIViewController {
    
    var ViewCarSelection : HomePageCarSelection?
    var rideNowDetailView : RideNowDetailView?

    @IBOutlet weak var viewAddressSelection: UIView!
    @IBOutlet weak var viewDropLocation: UIView!
    @IBOutlet weak var viewSourceLocation: UIView!
    @IBOutlet weak var viewGoogleMap: GMSMapView!
    
    @IBOutlet weak var imageMenu: UIImageView!
    
    var rideNowHeightConstrait = NSLayoutConstraint()
    
    var isShowFareDetailView :  Bool = true {
        didSet {
            
            let direction : Transition = isShowFareDetailView ? .bottom : .top
            self.viewAddressSelection.showAnimateView((self.viewAddressSelection)!, isShow: !isShowFareDetailView, direction: direction)
            isShowFareDetailView ? self.loadRideNowDetailView() : self.removeRideNowDetailView()
            UIView.animate(withDuration: 1) {
                self.imageMenu.transform = CGAffineTransform(rotationAngle: .pi)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                self.imageMenu.image = self.isShowFareDetailView ? #imageLiteral(resourceName: "left-arrow1") : #imageLiteral(resourceName: "menu_icon")
                self.imageMenu.transform = .identity
            }
           
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
       
        
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override class var identifier: String {
        return Storyboard.Ids.DrawerController
    }
    
    private func initialLoad() {
        self.loadCarSelectionView()

        
        self.imageMenu.isUserInteractionEnabled = true
        self.imageMenu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(menuAction)))
        
        self.viewSourceLocation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(locationTapAction)))
        
            
    }
    
    @IBAction func locationTapAction(){
       
        let navigation = UINavigationController(rootViewController: LocationSearchTableViewController())
        self.presentWithClass(viewController: navigation)
    }
    
    @IBAction func menuAction(){
        self.drawerController?.openSide(.left)
        //self.drawerController?.setAnimator(Drawer, for: .left)
        self.drawerController?.getSideOption(for: .left)?.isBlur = true
       
    }
    
}



