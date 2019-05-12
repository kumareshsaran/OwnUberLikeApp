//
//  SideBarTableViewController.swift
//  User
//
//  Created by CSS on 02/05/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit
import SafariServices
import KWDrawerController

class SideBarTableViewController: UITableViewController {
    
    @IBOutlet private var imageViewProfile : UIImageView!
    @IBOutlet private var labelName : UILabel!
    @IBOutlet private var labelEmail : UILabel!
    @IBOutlet private var viewShadow : UIView!
    @IBOutlet private weak var profileImageCenterContraint : NSLayoutConstraint!
    
     private let sideBarList = [Constants.string.yourTrips.localize(),Constants.string.payment.localize(),Constants.string.help.localize(),Constants.string.setting.localize(),Constants.string.aboutUs.localize(),Constants.string.logout.localize()]
    
    private let sideBarListImage = [#imageLiteral(resourceName: "yourTrips"),#imageLiteral(resourceName: "credit-cards"),#imageLiteral(resourceName: "help"),#imageLiteral(resourceName: "settings-work-tool1"),#imageLiteral(resourceName: "about-us1"),#imageLiteral(resourceName: "logout")]
    
    
    
    private let cellId = "cellId"
    
    private lazy var loader : UIView = {
        
        return createActivityIndicator(self.view)
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.localize()
        self.setValues()
        self.navigationController?.isNavigationBarHidden = true
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setLayers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false
    }
    
}

// MARK:- Methods

extension SideBarTableViewController {
    
    private func initialLoads() {
        
        // self.drawerController?.fadeColor = UIColor
        self.drawerController?.shadowOpacity = 0.2
        let fadeWidth = self.view.frame.width*(0.2)
      //  self.profileImageCenterContraint.constant = 0 //-(fadeWidth/3)
        self.drawerController?.drawerWidth = Float(self.view.frame.width - fadeWidth)
        self.viewShadow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewAction)))
        
    }
    
    // MARK:- Set Designs
    
    private func setLayers(){
        
        //self.viewShadow.addShadow()
        self.imageViewProfile.makeRoundedCorner()
        
    }
    //MARK:- SetValues
    
    private func setValues(){
        
        Cache.image(forUrl: Common.getImageUrl(for: User.main.picture)) { (image) in
            DispatchQueue.main.async {
                self.imageViewProfile.image = image == nil ? #imageLiteral(resourceName: "MenProfile") : image
            }
        }
        self.labelName.text = "John"//String.removeNil(User.main.firstName)+" "+String.removeNil(User.main.lastName)
        self.labelEmail.text = "John@gmail.com"//User.main.mobile
    }
    
    
    
    // MARK:- Localize
    private func localize(){
        
        self.tableView.reloadData()
        
    }
    
    // MARK:- ImageView Action
    
    @IBAction private func imageViewAction() {
        self.drawerController?.closeSide()
        self.push(to: Storyboard.Ids.ProfilePageViewController)
    }
    
    
    // MARK:- Selection Action For TableView
    
    private func select(at indexPath : IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SideMenuCell
        switch cell.labelTitle.text {
        case Constants.string.yourTrips.localize():
            self.push(to: Storyboard.Ids.yourTripsViewController)
        case Constants.string.aboutUs.localize():
            break
        case Constants.string.payment.localize():
            self.push(to: Storyboard.Ids.PaymentViewController)
        case Constants.string.setting.localize():
            break
        case Constants.string.aboutUs.localize():
            break
        case Constants.string.logout.localize():
            self.navigationController?.popToRootViewController(animated: true)
        default:
            break
        }
        
    }
    
    private func push(to identifier : String) {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: identifier)
        (self.drawerController?.getViewController(for: .none) as? UINavigationController)?.pushViewController(viewController, animated: true)
    }
    
    
    // MARK:- Logout
    
    private func logout() {
        
    /*    let alert = UIAlertController(title: nil, message: Constants.string.areYouSureWantToLogout.localize(), preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: Constants.string.logout.localize(), style: .destructive) { (_) in
            self.loader.isHidden = false
            self.presenter?.post(api: .logout, data: nil)
        }
        
        let cancelAction = UIAlertAction(title: Constants.string.Cancel.localize(), style: .cancel, handler: nil)
        
        alert.view.tintColor = .primary
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }*/
    
}

}
// MARK:- TableView

extension SideBarTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SideMenuCell
//        tableCell.textLabel?.textColor = .secondary
//        tableCell.textLabel?.text = sideBarList[indexPath.row].localize()
//        Common.setFont(to: tableCell.textLabel!, isTitle: true, size: 22)
        
        tableCell.labelTitle.text = sideBarList[indexPath.row].localize()
        //tableCell.imageViewForTitle.image = self.sideBarListImage[indexPath.row].withRenderingMode(.alwaysTemplate)
        tableCell.imageViewForTitle.tintImageColor(setimage: self.sideBarListImage[indexPath.row])
        
        
        if indexPath.row == 0 {
            tableCell.topLineView.isHidden = true
        }
        if indexPath.row == self.sideBarList.count - 1 {
             tableCell.buttonLineView.isHidden = true
        }
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideBarList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.select(at: indexPath)
        self.drawerController?.closeSide()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


// MARK:- PostViewProtocol

extension SideBarTableViewController : PostViewProtocol {
    
    func onError(api: Base, message: String, statusCode code: Int) {
        
        DispatchQueue.main.async {
            self.loader.isHidden = true
            showAlert(message: message, okHandler: nil, fromView: self)
        }
    }
    
    func success(api: Base, message: String?) {
        DispatchQueue.main.async {
            self.loader.isHidden = true
            forceLogout()
        }
    }
}
extension SideBarTableViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.popOrDismiss(animation: true)
    }
}


class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var imageViewForTitle: UIImageView!
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var buttonLineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

