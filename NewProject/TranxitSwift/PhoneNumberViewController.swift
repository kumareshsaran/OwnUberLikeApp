
//
//  PhoneNumberViewController.swift
//  User
//
//  Created by CSS on 24/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController {
    @IBOutlet weak var textfiledPhoneNumber: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var viewMain: UIView!
    
    @IBOutlet weak var labelEnterPhoneNumber: UILabel!
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var textfiledCC: UITextField!
    @IBOutlet weak var ButtonBottomContraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialLoad()
      
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 0.5) {
//
//
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           
            self.textfiledPhoneNumber.becomeFirstResponder()
        }
         self.addKeyBoardObserver(with: self.ButtonBottomContraint)
    
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.textfiledPhoneNumber.resignFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
    deinit {
        print("deinit")
    }
    
    private func intialLoad(){
       
        localization()
        setNavigation()
        DispatchQueue.main.async {
            self.setScrollView()
        }
        //self.buttonNext.isEnabled = false
        if #available(iOS 11.0, *) {
            self.buttonNext.isSpringLoaded = true
        } else {
            // Fallback on earlier versions
        }
        
        self.buttonNext.showsTouchWhenHighlighted = true
        
        self.textfiledPhoneNumber.delegate = self
       // self.buttonNext.alpha = 0.5
        
        self.buttonNext.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    @IBAction func nextAction(){
        self.push(id: Storyboard.Ids.PhoneNumverVerificationViewController, animation: true, fromSB: Router.user)
    }
    
    private func setScrollView(){
        
        self.viewMain.frame = self.view.frame
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        self.scrollView.addSubview(self.viewMain)
        
        
//        Common().getKeyBoardHeight { [weak self] (height) in
//            self?.ButtonBottomContraint.constant = height
//        }
//
        
    
    }
    
    private func localization(){
        
        self.labelEnterPhoneNumber.text = Constants.string.enterYourMobileNumber.localize()
        self.textfiledPhoneNumber.placeholder = Constants.string.phoneNumber.localize()
        self.textfiledCC.placeholder = Constants.string.cc.localize()
        self.buttonNext.setTitle(Constants.string.next.localize(), for: .normal)
        
    }
    
    private func setNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButton { [weak self] in
            self?.popOrDismiss(animation: true)
        }
    }


}

extension PhoneNumberViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField.text?.count ?? 0 > 1{
//            self.buttonNext.isEnabled = true
//            self.buttonNext.alpha = 1
//        }else{
//             self.buttonNext.isEnabled = true
//            self.buttonNext.alpha = 0.5
//        }
        return true
    }
}

