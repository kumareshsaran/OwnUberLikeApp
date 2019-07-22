//
//  ProfilePageViewController.swift
//  User
//
//  Created by CSS on 05/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import Foundation

class ProfilePageViewController: UITableViewController {


    @IBOutlet weak var labelAccountInfo: UILabel!
    @IBOutlet weak var ImageViewProfileBG: UIImageView!
    @IBOutlet weak var textFieldJoinDate: UITextField!
    @IBOutlet weak var imageViewProfilePicture: UIImageView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var labelPhoneNumber: UILabel!
    @IBOutlet weak var TextFieldPhoneNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialLoad()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(statusBarHeightChange(sender:)) , name: Notification.Name.UIApplicationDidChangeStatusBarFrame, object: nil)
        
    }
    
//    @IBAction func statusBarHeightChange(sender: NotificationCenter){
//        print(#function)
//    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageViewProfilePicture.makeRoundedCorner()
    }
    
    private func  initialLoad(){
        setNavigation()
        localize()
        self.imageViewProfilePicture.isUserInteractionEnabled = true
        self.imageViewProfilePicture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickProfileImage)))
        if #available(iOS 13.0, *) {
            
           
//            let configuration = UIImage.SymbolConfiguration(scale: .large)
//            self.imageViewProfilePicture.preferredSymbolConfiguration = configuration
//            self.imageViewProfilePicture.image = UIImage(systemName: "person.crop.circle.fill")
//            self.imageViewProfilePicture.tintColor = .black
            

            
        } else {
            // Fallback on earlier versions
            self.imageViewProfilePicture.image = #imageLiteral(resourceName: "MenProfile")
        }
    }
    
    @IBAction func pickProfileImage(){
        self.showImage { (image) in
            self.imageViewProfilePicture.image = image
            self.ImageViewProfileBG.image = image
        }
    }
    
    private func setNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.title = Constants.string.profile.localize()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "left-arrow1"), style: .done, target: self, action: #selector(menuAction(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.string.save.localize(), style: .plain, target: self, action: #selector(menuAction(sender:)))
    }
    
    @IBAction func menuAction(sender : UIBarButtonItem){
        if sender == self.navigationItem.leftBarButtonItem {
            self.popOrDismiss(animation: true)
        }else{
            print("save")
        }
    }
    
    private func localize(){
        self.labelEmail.text = Constants.string.email.localize()
        self.labelPhoneNumber.text = Constants.string.phone.localize()
        self.labelAccountInfo.text = Constants.string.accountInfo.localize()
    }
    
    
 /*   override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let inset = abs(scrollView.contentOffset.y/ImageViewProfileBG.frame.height)
        
        if scrollView.contentOffset.y < -64 {
         
        }else if scrollView.contentOffset.y > 0 && self.navigationItem.rightBarButtonItem?.image == UIImage(named: ""){
            UIView.animate(withDuration: 1) {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem().rightBarButtonItemWithImage(image: #imageLiteral(resourceName: "MenProfile"))
            }
            
        }else{
            UIView.animate(withDuration: 1) {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: .done, target: self, action: #selector(self.menuAction))//UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            }
           
        }
        
        print(#function)
    }*/
}

extension UIBarButtonItem{
    func rightBarButtonItemWithImage(image: UIImage) -> UIBarButtonItem {
        let button: UIButton = UIButton()
        button.setImage(image.resizeImage(newWidth: 30), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        button.makeRoundedCorner()
        return barButton
       
    }
}
