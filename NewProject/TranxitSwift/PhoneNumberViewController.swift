
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
    @IBOutlet weak var scrollViewButtomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var textfiledCC: UITextField!
    @IBOutlet weak var ButtonBottomContraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialLoad()
    }
    
  //  private func
    
    @IBAction func resetTapped(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.setScrollView()
        })
            
        
        self.buttonNext.showsTouchWhenHighlighted = true
        self.textfiledPhoneNumber.delegate = self
        self.buttonNext.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    @IBAction func nextAction(){
        self.push(id: Storyboard.Ids.PhoneNumverVerificationViewController, animation: true, fromSB: Router.user)
    }
    
    private func setScrollView(){
        
        self.viewMain.frame = self.view.frame
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height)
        self.scrollView.addSubview(self.viewMain)
        
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

//MARK:- UITextFieldDelegate
extension PhoneNumberViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9529411765, blue: 0.9921568627, alpha: 1)
        textField.setLeftPadding(point: CGFloat(16.00))
        if textField == self.textfiledCC {
             let countryCodeVC = CountryCodeSelectionViewController()
                 countryCodeVC.countryDelegate = self
                let nav = UINavigationController(rootViewController: countryCodeVC)
                self.presentWithClass(viewController: nav)
       }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.white
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let stringCount = string.count + textField.text!.count - range.length
        if stringCount ?? 0 > 5{
            self.buttonNext.isEnabled = true
            self.buttonNext.alpha = 1
        }else{
             self.buttonNext.isEnabled = true
             self.buttonNext.alpha = 0.5
        }
        return true
    }
}

extension PhoneNumberViewController : CountrySelectionDelegate {
    func selectedCountry(country: Country) {
        self.textfiledCC.text = country.dial_code
    }
}

