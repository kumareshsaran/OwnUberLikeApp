//
//  Global.swift
//  User
//
//  Created by imac on 1/1/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit
import Foundation
import PopupDialog
import AudioUnit
import Lottie

var currentBundle : Bundle!
var selectedShortCutItem : CoreDataEntity?
private var container: UIView?
// Store Favourite Locations

typealias FavouriteLocation = (address :String,location :LocationDetail?)

var favouriteLocations = [FavouriteLocation]()

// MARK:- Store Favourite Locations



func needsUpdate()  {
    let infoDictionary = Bundle.main.infoDictionary
    let appID = infoDictionary!["CFBundleIdentifier"] as! String
    let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(appID)")
    guard let data = try? Data(contentsOf: url!) else {
        print("There is an error!")
        return ;
    }
    let lookup = (try? JSONSerialization.jsonObject(with: data , options: [])) as? [String: Any]
    if let resultCount = lookup!["resultCount"] as? Int, resultCount == 1 {
        if let results = lookup!["results"] as? [[String:Any]] {
            if let appStoreVersion = results[0]["version"] as? String{
                let currentVersion = infoDictionary!["CFBundleShortVersionString"] as? String
                if !(appStoreVersion == currentVersion) {
                    print("Need to update [\(appStoreVersion) != \(currentVersion)]")
                    UIApplication.shared.keyWindow?.rootViewController?.present(showAlert(message: "newVersion", handler: { (action) in
                        print(action)
                        openUrl(String: "itms-apps://itunes.apple.com/app/id1436382659")
                        
                    }), animated: true, completion: nil)
                    
                    return
                }
            }
        }
    }
}

func openUrl(String : String?){
    if let providerNumber = String, let url = URL(string: "\(providerNumber)"), UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
        UIScreen.main.focusedView?.make(toast: "cannotMakeCallAtThisMoment".localize())
    }
}


//MARK:- Show Alert
func showAlert(message : String?, handler : ((UIAlertAction) -> Void)? = nil)->UIAlertController{
    
    let alert = UIAlertController(title: AppName, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title:  "Constants.string.OK", style: .default, handler: handler))
    alert.view.tintColor = .primary
    return alert
    
    
}


//MARK:- Show Alert With Action

 func showAlert(message : String?, okHandler : (()->Void)?, fromView : UIViewController){
    
   /* let alert = UIAlertController(title: AppName,
                                  message: message,
        preferredStyle: .alert)
    let okAction = UIAlertAction(title: Constants.string.OK, style: .default, handler: okHandler)
    
    let cancelAction = UIAlertAction(title: Constants.string.Cancel, style: .destructive, handler: nil)
    
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    alert.view.tintColor = .primary */
    
    let alert = PopupDialog(title: message, message: nil)
    let okButton =  PopupDialogButton(title: "OK", action: {
        okHandler?()
        alert.dismiss()
    })
    alert.transitionStyle = .zoomIn
    alert.addButton(okButton)
    fromView.present(alert, animated: true, completion: nil)
    
}


//MARK:- Show Alert With Action

func showAlert(message : String?, okHandler : (()->Void)?, cancelHandler : (()->Void)?, fromView : UIViewController){
    
    let alert = PopupDialog(title: message, message: nil)
    let okButton =  PopupDialogButton(title: "Constants.string.OK.localize()", action: {
        okHandler?()
        alert.dismiss()
    })
    let cancelButton =  PopupDialogButton(title: "Constants.string.Cancel.localize()", action: {
        cancelHandler?()
        alert.dismiss()
    })
    alert.transitionStyle = .zoomIn
    cancelButton.titleColor = .red
    okButton.titleColor = .primary
    alert.addButton(okButton)
    alert.addButton(cancelButton)
    fromView.present(alert, animated: true, completion: nil)
    
}

//MARK:- ShowLoader

internal func createActivityIndicator(_ uiView : UIView)->UIView{
    
    var container: UIView = UIView(frame: CGRect.zero)
    container.layer.frame.size = uiView.frame.size
    container.center = CGPoint(x: uiView.bounds.width/2, y: uiView.bounds.height/2)
    container.backgroundColor = UIColor(white: 0.2, alpha: 0.3)
    
    let loadingView: UIView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = container.center
    loadingView.backgroundColor = .white //UIColor(white:0.1, alpha: 0.7)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    loadingView.layer.shadowRadius = 5
    loadingView.layer.shadowOffset = CGSize(width: 0, height: 4)
    loadingView.layer.opacity = 2
    loadingView.layer.masksToBounds = false
    loadingView.layer.shadowColor = UIColor.gray.cgColor
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    actInd.clipsToBounds = true
    actInd.activityIndicatorViewStyle = .gray
    
    
    
    
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    container.isHidden = true
    uiView.addSubview(container)
    actInd.startAnimating()
    
    return container
    
}

internal func startLoading(){
    
    let newViewWidth = UIScreen.main.bounds.size.width
    let newViewHeight = UIScreen.main.bounds.size.height
    
    container = UIView(frame: CGRect(x: 0, y: 0, width: newViewWidth, height: newViewHeight))
    container?.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
    
    let animationView = LOTAnimationView(name: "Mygo_Loader_Type2_IOS")
    animationView.loopAnimation = true
    animationView.frame = CGRect(x: (newViewWidth - 150)/2, y: (newViewHeight - 150)/2, width: 150, height: 150)
    container?.addSubview(animationView)
    UIApplication.shared.keyWindow!.addSubview(container!)
    UIApplication.shared.keyWindow!.bringSubview(toFront: container!)
    animationView.play{ (finished) in
        
    }
    
}



internal func storeInUserDefaults(){
    
   /* let data = NSKeyedArchiver.archivedData(withRootObject: User.main)
    UserDefaults.standard.set(data, forKey: Keys.list.userData)
    let groupDefaults = UserDefaults(suiteName: Keys.list.appGroup)
    groupDefaults?.set(true, forKey: Keys.list.isLoggedIn)
    UserDefaults.standard.synchronize()
    groupDefaults?.synchronize()
    print("Store in UserDefaults--", UserDefaults.standard.value(forKey: Keys.list.userData) ?? "Failed")*/
}

// Retrieve from UserDefaults
internal func retrieveUserData()->Bool{

    if let data = UserDefaults.standard.object(forKey: Keys.list.userData) as? Data, let userData = NSKeyedUnarchiver.unarchiveObject(with: data) as? User {
        User.main = userData
    }
    return User.main.accessToken != nil
    
}

// Clear UserDefaults
internal func clearUserDefaults(){
    
  /*  User.main = initializeUserData()  // Clear local User Data
    UserDefaults.standard.set(nil, forKey: Keys.list.userData)
    let groupDefaults = UserDefaults(suiteName: Keys.list.appGroup)
    groupDefaults?.set(false, forKey: Keys.list.isLoggedIn)
    UserDefaults.standard.removeVolatileDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.synchronize()
    groupDefaults?.synchronize()
    print("Clear UserDefaults--", UserDefaults.standard.value(forKey: Keys.list.userData) ?? "Success")*/
    
}

// MARK:- Force Logout

func forceLogout(with message : String? = nil) {
    

    clearUserDefaults()
    UIApplication.shared.windows.last?.rootViewController?.popOrDismiss(animation: true)
    let navigationController = UINavigationController(rootViewController: Router.user.instantiateViewController(withIdentifier: Storyboard.Ids.LaunchViewController))
    navigationController.isNavigationBarHidden = true
    UIApplication.shared.windows.first?.rootViewController = navigationController
    UIApplication.shared.windows.first?.makeKeyAndVisible()
    if message != nil {
        UIApplication.shared.keyWindow?.makeToast(message)
    }
}

// MARK:- Add Vibration

func vibrate(with vibration : Vibration) {
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
}

// Initialize User

internal func initializeUserData()->User
{
    return User()
}


func setLocalization(language : Language){
    
    if let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj"), let bundle = Bundle(path: path) {
        
        currentBundle = bundle
        
    } else {
        currentBundle = .main
    }
    
    
}


