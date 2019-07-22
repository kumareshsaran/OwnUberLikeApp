//
//  YourTripsViewController.swift
//  User
//
//  Created by CSS on 13/06/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

class YourTripsDetailViewController: UITableViewController {
    
    @IBOutlet private weak var imageViewMap : UIImageView!
    @IBOutlet private weak var imageViewProvider : UIImageView!
    @IBOutlet private weak var labelProviderName : UILabel!
    @IBOutlet private weak var viewRating : FloatRatingView!
    @IBOutlet private weak var labelDate : UILabel!
    @IBOutlet private weak var labelTime : UILabel!
    @IBOutlet private weak var labelBookingId : UILabel!
    @IBOutlet private weak var labelPayViaString : UILabel!
    @IBOutlet private weak var imageViewPayVia : UIImageView!
    @IBOutlet private weak var labelPayVia : UILabel!
    @IBOutlet private weak var labelPrice : UILabel!
    @IBOutlet private weak var labelCommentsString : UILabel!
    @IBOutlet private weak var textViewComments : UITextView!
    @IBOutlet private weak var buttonCancelRide : UIButton!
    @IBOutlet private weak var buttonViewReciptAndCall : UIButton!
    @IBOutlet private weak var viewLocation : UIView!
    @IBOutlet private weak var labelSourceLocation : UILabel!
    @IBOutlet private weak var labelDestinationLocation : UILabel!
    @IBOutlet private weak var viewComments : UIView!
    @IBOutlet private weak var stackViewButtons : UIStackView!
    
    var isUpcomingTrips = false  // Boolean to handle Past and Upcoming Trips
    
    lazy var loader  : UIView = {
        return createActivityIndicator(self.view)
    }()
    
    private var heightArray : [CGFloat] = [62,75,70,145]

    private var blurView : UIView?
    private var requestId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
        self.localize()
        self.setDesign()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setLayouts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.imageViewMap.image = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if isUpcomingTrips {
//        } else {
//            self.viewLocation.removeFromSuperview()
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideRecipt()
    }

}

// MARK:- Methods

extension YourTripsDetailViewController {
    
    // MARK:- Initial Loads
    
    private func initialLoads() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.backButtonClick))
        self.buttonCancelRide.isHidden = !isUpcomingTrips
        self.buttonCancelRide.addTarget(self, action: #selector(self.buttonCancelRideAction(sender:)), for: .touchUpInside)
        self.buttonViewReciptAndCall.addTarget(self, action: #selector(self.buttonCallAndReciptAction(sender:)), for: .touchUpInside)
        
        if #available(iOS 11.0, *) {
//            self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
//              self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
      
       
      self.title = Constants.string.pastTripDetail.localize()
        
        self.viewRating.minRating = 1
        self.viewRating.maxRating = 5
        self.viewRating.emptyImage = #imageLiteral(resourceName: "StarEmpty")
        self.viewRating.fullImage = #imageLiteral(resourceName: "StarFull")
        self.imageViewMap.image = #imageLiteral(resourceName: "rd-map")
        //UIApplication.shared.keyWindow?.addSubview(self.stackViewButtons)
    }
    
    
    func setId(id : Int) {
        self.requestId = id
    }
    
    // MARK:- Localize
    private func localize() {
        
        
    }
    
    // MARK:- Set Designs
    
    private func setDesign() {
        
       Common.setFont(to: self.labelCommentsString, isTitle: true)
       Common.setFont(to: self.labelPayViaString, isTitle:  true)
        Common.setFont(to: self.labelDate, size : 12)
       Common.setFont(to: self.labelTime, size : 12)
       Common.setFont(to: self.labelBookingId)
       Common.setFont(to: self.labelPrice)
       Common.setFont(to: self.labelProviderName)
       Common.setFont(to: self.labelSourceLocation, size : 12)
       Common.setFont(to: self.labelDestinationLocation, size : 12)
       Common.setFont(to: self.labelPayVia)
       Common.setFont(to: self.buttonViewReciptAndCall, isTitle: true)
       if isUpcomingTrips {
            Common.setFont(to: self.buttonCancelRide, isTitle: true)
       }
    }
    
    // MARK:- Layouts
    
    private func setLayouts() {
        
        self.imageViewProvider.makeRoundedCorner()
        let height = tableView.tableFooterView?.frame.origin.y ?? 0//(self.buttonViewReciptAndCall.convert(self.buttonViewReciptAndCall.frame, to: UIApplication.shared.keyWindow ?? self.tableView).origin.y+self.buttonViewReciptAndCall.frame.height)
        guard height < UIScreen.main.bounds.height else { return }
        let footerHeight = UIScreen.main.bounds.height-height
        self.tableView.tableFooterView?.frame.size.height = (footerHeight-(self.buttonViewReciptAndCall.frame.height*2)-(self.navigationController?.navigationBar.frame.height ?? 0))
    }
    
    
    // MARK:- Set values
    
    private func setValues() {
   
        
    }
    
    // MARK:- Cancel Ride
    
    @IBAction private func buttonCancelRideAction(sender : UIButton) {
        

        
    }
    
    // MARK:- Call and View Recipt
    
    @IBAction private func buttonCallAndReciptAction(sender : UIButton) {

        
    }
    
    // MARK:- Show Recipt
    private func showRecipt() {
        

        
    }
    
    
    private func addBlurView() {
        
        self.blurView = UIView(frame: UIScreen.main.bounds)
        self.blurView?.alpha = 0
        self.blurView?.backgroundColor = .black
        self.blurView?.isUserInteractionEnabled = true
        self.view.addSubview(self.blurView!)
        self.blurView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hideRecipt)))
        UIView.animate(withDuration: 0.2, animations: {
            self.blurView?.alpha = 0.6
        })
        
    }
    
    // MARK:- Remove Recipt
   @IBAction private func hideRecipt() {
        
  
        
    }
    
}

// MARK:- Postview Protocol

extension YourTripsDetailViewController: PostViewProtocol {
    
    func onError(api: Base, message: String, statusCode code: Int) {
        DispatchQueue.main.async {
            self.loader.isHidden = true
            showAlert(message: message, okHandler: nil, fromView: self)
        }
    }
    


    func success(api: Base, message: String?) {
        DispatchQueue.main.async {
            self.loader.isHidden = true
            showAlert(message: message, okHandler: {
                 self.popOrDismiss(animation: true)
            }, fromView: self)
           
        }
    }
    
    
}

//// MARK:- ScrollView Delegate
//
//extension YourTripsDetailViewController {
//
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        guard scrollView.contentOffset.y<0 else { return }
//
//        let inset = abs(scrollView.contentOffset.y/imageViewMap.frame.height)
//
//        self.imageViewMap.transform = CGAffineTransform(scaleX: 1+inset, y: 1+inset)
//
//    }
//
//}

extension YourTripsDetailViewController {
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if isUpcomingTrips && indexPath.row == 3 {
        return 0
    } else  {
         return heightArray[indexPath.row]
    }

    }
    
}



