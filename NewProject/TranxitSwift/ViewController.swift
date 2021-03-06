
import UIKit
import Foundation

private var bottomConstraint : NSLayoutConstraint?
private var imageCompletion : ((UIImage?)->())?
private var constraintValue : CGFloat = 0

extension UIViewController {
    

    
    func setPresenter(){
        
        if let view = self as? PostViewProtocol {
            
            view.presenter = presenterObject
            view.presenter?.controller = view
            presenterObject = view.presenter
            
        }
        
    }
    
    //MARK:- Pop or dismiss View Controller
    
    func popOrDismiss(animation : Bool){
        
        DispatchQueue.main.async {
            
            if self.navigationController != nil {
                
                if let push = self.navigationController?.popViewController(animated: animation) {
                    self.navigationController?.popViewController(animated: animation)
                }else{
                    self.dismiss(animated: animation, completion: nil)
                }
            } else {
                
                self.dismiss(animated: animation, completion: nil)
            }
            
        }
        
    }
    
    //MARK:- Present
    
    func present(id : String, animation : Bool, fromSB storyBoard: UIStoryboard = Router.main,presentationStyle: UIModalPresentationStyle = .fullScreen){
        
           let vc = storyBoard.instantiateViewController(withIdentifier: id)
            vc.modalPresentationStyle = presentationStyle
           self.present(vc, animated: animation, completion: nil)
        
        
    }
    
    func presentWithClass(viewController : UIViewController){
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    //MARK:- Push
    
    func push(id : String, animation : Bool, fromSB storyBoard: UIStoryboard? = Router.main){
        
        if let vc = storyBoard?.instantiateViewController(withIdentifier: id){
            self.navigationController?.pushViewController(vc, animated: animation)
        }
        
    }
    
    //MARK:- Push To Right
    
    func pushRight(toViewController viewController : UIViewController){
        
        self.makePush(transition: kCATransitionFromLeft)
        navigationController?.pushViewController(viewController, animated: false)
        
    }
    
    private func makePush(transition type : String){
        
        let transition = CATransition()
        transition.duration = 0.45
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        transition.type = kCATransitionPush
        transition.subtype = type
        //transition.delegate = self
        navigationController?.view.layer.add(transition, forKey: nil)
        //navigationController?.isNavigationBarHidden = false
        
    }
    
    func popLeft() {
        
        self.makePush(transition: kCATransitionFromRight)
        navigationController?.popViewController(animated: true)
        
    }
    
   
    //MARK:- Add observers
    
    func addKeyBoardObserver(with constraint : NSLayoutConstraint){
        
        bottomConstraint = constraint
        
        constraintValue = constraint.constant
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(info:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(info:)), name: .UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(info:)), name: .UIKeyboardWillChangeFrame, object: nil)
      
        
    }
    //MARK:- Keyboard will show
    
    @IBAction private func keyboardWillShow(info : NSNotification){
        
        guard let keyboard = (info.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        bottomConstraint?.constant = (keyboard.height)  + 10
        self.view.layoutIfNeeded()
    }
    
    
    //MARK:- Keyboard will hide
    
    @IBAction private func keyboardWillHide(info : NSNotification){
        
        bottomConstraint?.constant = constraintValue
        self.view.layoutIfNeeded()
        
    }
    
    
    //MARK:- Back Button Action
    
    @IBAction func backButtonClick() {
        
        self.popOrDismiss(animation: true)
        
    }
    
    
    
    //MARK:- Show Image Selection Action Sheet
    
    func showImage(with completion : @escaping ((UIImage?)->())){
        
        let alert = UIAlertController(title: "selectSource", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constants.string.camera, style: .default, handler: { (_) in
            self.chooseImage(with: .camera)
        }))
        alert.addAction(UIAlertAction(title: Constants.string.photoLibrary, style: .default, handler: { (_) in
            self.chooseImage(with: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: Constants.string.Cancel, style: .cancel, handler:nil))
        alert.view.tintColor = .primary
        imageCompletion = completion
        self.present(alert, animated: true, completion: nil)
        
    }

    // MARK:- Show Image Picker
    
    private func chooseImage(with source : UIImagePickerControllerSourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = source
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
  /*  //MARK:- Right Bar Button Action
    
    @IBAction private func rightBarButtonAction(){
        
        let alertRightBar = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertRightBar.addAction(UIAlertAction(title: Constants.string.newGroup, style: .default, handler: { (Void) in
            
        }))
        
        alertRightBar.addAction(UIAlertAction(title: Constants.string.newBroadcast, style: .default, handler: { (Void) in
            
        }))
        
        alertRightBar.addAction(UIAlertAction(title: Constants.string.starredMessages, style: .default, handler: { (Void) in
            
        }))
        
        alertRightBar.addAction(UIAlertAction(title: Constants.string.settings, style: .default, handler: { (Void) in
            
            self.pushRight(toViewController: self.storyboard!.instantiateViewController(withIdentifier: Storyboard.Ids.SettingViewController))
            
        }))
        
        alertRightBar.addAction(UIAlertAction(title: Constants.string.Cancel, style: .cancel, handler: { (Void) in
            
        }))
        
        alertRightBar.view.tintColor = .primary
        
        self.present(alertRightBar, animated: true, completion: nil)
        
    }  */
   
    
    //MARK:- Show Search Bar with self delegation
    
    @IBAction private func showSearchBar(){
        
       let searchBar = UISearchController(searchResultsController: nil)
       searchBar.searchBar.delegate = self as? UISearchBarDelegate
       searchBar.hidesNavigationBarDuringPresentation = false
       searchBar.dimsBackgroundDuringPresentation = false
       searchBar.searchBar.tintColor = .primary
       self.present(searchBar, animated: true, completion: nil)
        
    }
    
    
    
}

//MARK:- UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true) {
            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                imageCompletion?(image)
            }
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}





