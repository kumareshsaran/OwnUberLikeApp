//
//  LaunchViewController.swift
//  User
//
//  Created by CSS on 27/04/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    
    @IBOutlet private var buttonSignIn : UIButton!
    @IBOutlet private var buttonSignUp : UIButton!
    @IBOutlet private var buttonSocialLogin : UIButton!
    
    //private weak var viewWalkThrough : WalkThroughView?

    var presenter: PostPresenterInputProtocol?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

//MARK:- Methods
extension LaunchViewController {
    
    //MARK:- Initial Loads
    
    private func initialLoads(){
      
        self.setLocalization()
       
        self.buttonSignIn.addTarget(self, action: #selector(self.buttonSignInAction), for: .touchUpInside)
        self.buttonSignUp.addTarget(self, action: #selector(self.buttonSignUpAction), for: .touchUpInside)
        self.buttonSocialLogin.addTarget(self, action: #selector(self.buttonSocialLoginAction), for: .touchUpInside)
       // User.main.loginType = LoginType.manual.rawValue // Set default login as manual
    }
    
    private func setLocalization(){
        //MARK:- Method Localize Strings
       buttonSignIn.setTitle(Constants.string.bookYourRide.localize(), for: .normal)
    }
    
    
    @IBAction private func buttonSignInAction(){

       self.push(id: Storyboard.Ids.PhoneNumberViewController, animation: true, fromSB: Router.user)
        
    }
    
    @IBAction private func buttonSignUpAction(){
        
    self.push(id: Storyboard.Ids.PhoneNumberViewController, animation: true)
        
    }
    
    @IBAction private func buttonSocialLoginAction(){
        
      //  self.push(id: Storyboard.Ids.SocialLoginViewController, animation: true)
        
    }
    
  
}

extension LaunchViewController : PostViewProtocol {
    
    func onError(api: Base, message: String, statusCode code: Int) {
        
    }
}
