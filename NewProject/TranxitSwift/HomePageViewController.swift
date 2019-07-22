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

    @IBOutlet weak var viewGetCurrentLocation: UIView!
    @IBOutlet weak var viewAddressSelection: UIView!
    @IBOutlet weak var viewDropLocation: UIView!
    @IBOutlet weak var viewSourceLocation: UIView!
    @IBOutlet weak var viewGoogleMap: GMSMapView!
    
    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var imageCurrentLocation: UIImageView!
    
    @IBOutlet weak var viewSideMenu: UIView!
    var rideNowHeightConstrait = NSLayoutConstraint()
    
    var googleMapHelper = GoogleMapsHelper()
    
    
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
    
    fileprivate func getUserCuttentLocaton() {
        self.googleMapHelper.getCurrentLocation(onReceivingLocation: { (location) in
           // self.viewGoogleMap.animate(toLocation: )
            self.viewGoogleMap.animate(toZoom: 12)
            self.viewGoogleMap.animate(to: GMSCameraPosition(target: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), zoom: 12, bearing: location.coordinate.latitude, viewingAngle: location.coordinate.latitude))
            self.viewGoogleMap.isMyLocationEnabled = true
            self.viewGoogleMap.isBuildingsEnabled = true
            //self.viewGoogleMap.isTrafficEnabled = true

            self.googleMapHelper.setMapStyle(to: self.viewGoogleMap)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoad()
        getUserCuttentLocaton()
    }
     override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            let userInterfaceStyle = traitCollection.userInterfaceStyle
            if userInterfaceStyle == .light {
               // self.navigationController?.navigationBar.tintColor = .black
            }else{
                //self.navigationController?.navigationBar.tintColor = .black
            }
        } else {
            // Fallback on earlier versions
        } // Either .unspecified, .light, or .dark
         // Update your user interface based on the appearance
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
        
        if #available(iOS 13.0, *) {
          //  self.imageCurrentLocation.image = UIImage(systemName: "location")
        } else {
            self.imageCurrentLocation.image = #imageLiteral(resourceName: "navigation")
            // Fallback on earlier versions
        }
        
        self.viewGetCurrentLocation.isUserInteractionEnabled = true
        self.viewGetCurrentLocation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(currentLocationTapped)))
        
        [self.viewGetCurrentLocation,self.viewSideMenu].forEach({$0?.makeRoundedCorner()})
        
            
    }
    
    @IBAction func currentLocationTapped(){
        getUserCuttentLocaton()
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


//extension HomePageViewController : UIAdaptivePresentationControllerDelegate {
//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        .
//    }
//}


