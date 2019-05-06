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
        setScrollView()
        setNavigation()
        localize()
        textfelddOTP1.becomeFirstResponder()
        self.buttonSubmit.showsTouchWhenHighlighted = true
        
        self.buttonSubmit.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    private func setScrollView(){
        
        self.viewMain.frame = self.view.frame
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        self.scrollView.addSubview(self.viewMain)
        

        self.addKeyBoardObserver(with: self.buttonBottomConstraint)

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
       // self.push(id: HomePageViewController.identifier, animation: true)
       // self.push(id: HomePageViewController.identifier, animation: true, fromSB: Router.main)
        self.present(id: HomePageViewController.identifier, animation: true, fromSB: Router.main)
    }




}
