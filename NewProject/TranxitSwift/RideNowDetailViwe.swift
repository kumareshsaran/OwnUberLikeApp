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
    var viewMainHeight = UIView()
    
    @IBOutlet weak var tableviewFareDetails: UITableView!
    @IBOutlet weak var scrollBlurView: UIVisualEffectView!
    
    @IBOutlet weak var buttonRideNow: UIButton!
    @IBOutlet weak var buttonSourceAddress: UIButton!
    @IBOutlet weak var buttonDestinationAddress: UIButton!
    
    var rideNowHeightConstrait = NSLayoutConstraint()
    
    var onScrollTableView : ((CGPoint)->())?
    var onClickCancel : (()->())?
    var onClickSourceAddress : (()->())?
    var onClickDestinationAddress : (()->())?
    var onClickPayment : (()->())?
    
    var selectedIndex = -1
    
    let bgView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "WomenProfile")
        return view
    }()
    
    var CellCount = Int()
    
    var reloadWithAddData: Bool = false {
        didSet {
            CellCount = reloadWithAddData ? 5 : 0
            if CellCount == 5 {
                self.tableviewFareDetails.reloadData()
            }else{
                 self.tableviewFareDetails.reloadSections(IndexSet(integersIn: 1...1), with: .fade)
            }
           
        }
    }
    
    var isTableViewScrollEnable : Bool = true {
        didSet {
            self.tableviewFareDetails.isScrollEnabled = self.frame.height > self.viewMainHeight.frame.height / 2
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.viewMain.roundCorners(corners: [.topLeft , .topRight], radius: 10)
        self.viewMain.addShadow()
        
        [XIB.Names.FareTableViewCell, XIB.Names.BookForSomeOneTableViewCell,XIB.Names.CouponTableViewCell].forEach { (identifier) in
            self.tableviewFareDetails.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier )
        }
        
        self.tableviewFareDetails.delegate = self
        self.tableviewFareDetails.dataSource = self
        
        self.tableviewFareDetails.reloadData()
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(gestireAction(sender:))))
        self.buttonRideNow.showsTouchWhenHighlighted = true
        
        //self.reloadWithAddData = false
        
        self.buttonSourceAddress.addTarget(self, action: #selector(addreeButtonTapped(sender:)), for: .touchUpInside)
        self.buttonDestinationAddress.addTarget(self, action: #selector(addreeButtonTapped(sender:)), for: .touchUpInside)
        
        self.localize()
        
      
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    private func localize(){
        self.buttonRideNow.setTitle(Constants.string.rideNow.localize(), for: .normal)
    }
    
    @IBAction func buttonCancel(_ sender: Any) {
        self.onClickCancel?()
    }
    
    @IBAction func addreeButtonTapped(sender: UIButton){
        if sender == self.buttonSourceAddress {
            self.onClickSourceAddress?()
        }else{
            self.onClickDestinationAddress?()
        }
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
    }
    
}

extension RideNowDetailView : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else if section ==  1  {
            return CellCount
        }else if section == 2 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.FareTableViewCell, for: indexPath) as? FareTableViewCell {
                    cell.selectionStyle = .none
                    return cell
                }
                
            }else if indexPath.row == 1 {
                if let bookForSomeCell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.BookForSomeOneTableViewCell) as? BookForSomeOneTableViewCell{
                    return bookForSomeCell
                }
                
            }
        }else if  indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.CouponTableViewCell, for: indexPath) as? CouponTableViewCell {
                cell.selectionStyle = .none
                //let checkMark = cell.accessoryType == .checkmark ? .none : .checkmark
                
                cell.accessoryType = self.selectedIndex == indexPath.row ?.checkmark : .none
                return cell
            }
        }else if indexPath.section == 2 {
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 64
        case 1:
            return 100
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.reloadWithAddData = true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
    
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = Bundle.main.loadNibNamed(XIB.Names.RideNowHeaderSection, owner: self, options: nil)?.first as! RideNowHeaderSection
        if section == 1 {
            sectionView.setTitle(title: Constants.string.applyCoupon.localize(), imageTitle: #imageLiteral(resourceName: "discount"))
            sectionView.onClickCouponApply = { [weak self] in
                self?.reloadWithAddData = self?.reloadWithAddData ?? false ? false : true
            }
        }else if section == 2 {
            sectionView.setTitle(title: Constants.string.payment.localize(), imageTitle: #imageLiteral(resourceName: "salary"))
            sectionView.onClickCouponApply = { [weak self] in
               self?.onClickPayment?()
            }
        }
      
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 44
        case 2:
            return 44
        default:
            return 0
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            self.tableviewFareDetails.isScrollEnabled = false
        }else{
           isTableViewScrollEnable = true
        }
    }
    
}
