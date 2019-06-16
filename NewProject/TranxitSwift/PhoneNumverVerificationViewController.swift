//
//  PhoneNumverVerificationViewController.swift
//  User
//
//  Created by CSS on 29/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class PhoneNumverVerificationViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var labelEnterOTP: UILabel!
    @IBOutlet var viewMain: UIView!
    @IBOutlet weak var textFieldOTP2: UITextField!
    @IBOutlet weak var textfelddOTP1: UITextField!
    @IBOutlet weak var textFieldOTP3: UITextField!
    
    @IBOutlet weak var textField4: UITextField!
    
    @IBOutlet weak var labelWeHaveSentOTP: UILabel!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonResendCode: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        localize()
        
        self.buttonSubmit.showsTouchWhenHighlighted = true
        
        self.buttonSubmit.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setScrollView()
        }
        
        [self.textfelddOTP1,self.textFieldOTP2,self.textFieldOTP3,self.textField4].forEach { (textfiled) in
            textfiled?.delegate = self
            textfiled?.textAlignment = .center
            if #available(iOS 12.0, *) {
                textfiled?.textContentType = .oneTimeCode
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.addKeyBoardObserver(with: self.buttonBottomConstraint)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.textfelddOTP1.becomeFirstResponder()
        }
    }
    
    private func setScrollView(){
        self.viewMain.frame = self.view.frame
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        self.scrollView.addSubview(self.viewMain)
    }
    
    
    private func setNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButton { [weak self] in
            self?.popOrDismiss(animation: true)
        }
    }
    
    private func localize(){
        self.labelEnterOTP.text = Constants.string.enterYourOTP.localize()
        self.labelWeHaveSentOTP.text = Constants.string.weHaveSentYouOTP.localize()
        self.buttonSubmit.setTitle(Constants.string.next.localize(), for: .normal)
        self.buttonResendCode.setTitle(Constants.string.resentCode.localize(), for: .normal)
    }
    
    @IBAction func buttonAction(){
        let home = Router.main.instantiateViewController(withIdentifier: HomePageViewController.identifier)
        if #available(iOS 13.0, *) {
            home.modalPresentationStyle = .fullScreen
        } else {
            // Fallback on earlier versions
        }
       
        self.present(home, animated: true, completion: nil)
        
       //self.present(id: HomePageViewController.identifier, animation: true, fromSB: Router.main)
    }
}

extension PhoneNumverVerificationViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
       // textField.setLeftPadding(point: textField.frame.width / CGFloat(2.0))
        textField.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9529411765, blue: 0.9921568627, alpha: 1)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
       textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
       
        
        let updatedText = textFieldText.replacingCharacters(in: range, with: string)
        // txtAfterUpdate.stringByReplacingCharactersInRange(range, withString: string)
        if textField == textfelddOTP1 {
            if updatedText.count > 1 {
                textFieldOTP2.becomeFirstResponder()
                return false
            }
            if updatedText.count == 1 {
                textField.text = updatedText
                textFieldOTP2.becomeFirstResponder()
                return false
            }
        }
        else if textField == textFieldOTP2 {
            if updatedText.count > 1 {
                textFieldOTP3.becomeFirstResponder()
                return false
            }
            if updatedText.count == 1 {
                textField.text = updatedText
                textFieldOTP3.becomeFirstResponder()
                return false
            }else {
                textFieldOTP2.text = updatedText
                textfelddOTP1.becomeFirstResponder()
                return false
            }
        }
        else if textField == textFieldOTP3 {
            if updatedText.count > 1 {
                textField4.becomeFirstResponder()
                return false
            }
            if updatedText.count == 1 {
                textField.text = updatedText
                textField4.becomeFirstResponder()
                return false
            }else {
                textFieldOTP3.text = updatedText
                textFieldOTP2.becomeFirstResponder()
                return false
            }
        }
        else if textField == textField4 {
            if updatedText.count > 1 {
                textField4.resignFirstResponder()
                return false
            }
            if updatedText.count == 1 {
                textField.text = updatedText
                textField4.resignFirstResponder()
                return false
            }else{
                textField4.text = updatedText
                textFieldOTP3.becomeFirstResponder()
                return false
            }
        }
        return true
    
    }
}
