//
//  RideNowDetailViwe.swift
//  User
//
//  Created by CSS on 01/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class RideNowDetailView: UIView {
    
    @IBOutlet weak var viewMain: UIView!
    
    
    @IBOutlet weak var tableviewFareDetails: UITableView!
    @IBOutlet weak var scrollBlurView: UIVisualEffectView!
    
    @IBOutlet weak var buttonRideNow: UIButton!
    
    var rideNowHeightConstrait = NSLayoutConstraint()
    
    var viewMainHeight = UIView()
    
    var onScrollTableView : ((CGPoint)->())?
    var onClickCancel : (()->())?
    let bgView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "WomenProfile")
        return view
    }()
    
    var isTableViewScrollEnable : Bool = true {
        didSet {
            self.tableviewFareDetails.isScrollEnabled = self.frame.height > self.viewMainHeight.frame.height / 2
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.viewMain.roundCorners(corners: [.topLeft , .topRight], radius: 10)
        
        self.viewMain.addShadow()
        
        self.tableviewFareDetails.register(UINib(nibName: XIB.Names.FareTableViewCell, bundle: nil), forCellReuseIdentifier:XIB.Names.FareTableViewCell )
        
        self.tableviewFareDetails.delegate = self
        self.tableviewFareDetails.dataSource = self
        
        self.tableviewFareDetails.reloadData()
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(gestireAction(sender:))))
        
        self.buttonRideNow.showsTouchWhenHighlighted = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.backgroundColor = .white
        self.viewMain.backgroundColor = .white
    }
    
    private func localize(){
        self.buttonRideNow.setTitle(Constants.string.rideNow.localize(), for: .normal)
    }
    
    @IBAction func buttonCancel(_ sender: Any) {
        self.onClickCancel?()
    }
    
    @IBAction func gestireAction(sender: UIPanGestureRecognizer){
        let state = sender.state
        let translation = sender.translation(in: sender.view).y
        // translation = abs(translation)
        self.rideNowHeightConstrait.isActive = true
        self.layoutIfNeeded()
        
        if translation > 0 {
            if state == .changed {
                self.rideNowHeightConstrait.constant =  (self.viewMainHeight.frame.height)  - abs(translation)
            }else if state == .ended {
                if (self.viewMainHeight.frame.height)  - abs(translation) > self.viewMainHeight.frame.height / 2 {
                    
                    self.rideNowHeightConstrait.constant = self.viewMainHeight.frame.height
                    UIView.animate(withDuration: 0.001) {
                        self.layoutIfNeeded()
                    }
                    
                }else if (self.viewMainHeight.frame.height)  - abs(translation) < self.viewMainHeight.frame.height / 3 {
                  
                    self.rideNowHeightConstrait.constant = self.viewMainHeight.frame.height / 2
                    UIView.animate(withDuration: 0.001) {
                        self.layoutIfNeeded()
                    }
                    
                }
                else{
                    self.rideNowHeightConstrait.constant =  (self.viewMainHeight.frame.height)  - abs(translation)
                }
                isTableViewScrollEnable = true
            }
        }else{
            if state == .changed {
                self.rideNowHeightConstrait.constant =  (self.frame.height) - translation
                
                UIView.animate(withDuration: 0.001) {
                    self.layoutIfNeeded()
                }
            }else if state == .ended {
                isTableViewScrollEnable = true
            }
            
        }
        
        //        print("translation: \(translation)")
        //        print("state: \(state)")
        //        print("height : \((self.viewMainHeight.frame.height)  - sender.translation(in: sender.view).y)")
        
    }
    
}

extension RideNowDetailView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.FareTableViewCell, for: indexPath)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y <= 0 {
            self.tableviewFareDetails.isScrollEnabled = false
        }else{
            isTableViewScrollEnable = true
        }
        
        
        
    }
    
    
    
}
