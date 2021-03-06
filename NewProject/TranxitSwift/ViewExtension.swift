//
//  ViewExtension.swift
//  User
//
//  Created by CSS on 17/01/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

 var backCompletion : (()->())?
enum Transition {
    
    case top
    case bottom
    case right
    case left
    
    var type : String {
        
        switch self {
            
        case .top :
            return kCATransitionFromBottom
        case .bottom :
            return kCATransitionFromTop
        case .right :
            return kCATransitionFromLeft
        case .left :
            return kCATransitionFromRight
            
        }
        
    }
    
}
private var viewBackground : UIView?
var imageView_Help : UIImageView?// Background view object
var viewMain : UIView?
extension UIView {
    
    func underLineCALayer(textfiled : UITextField)->UIView{
        let border = UIView()
        let width = CGFloat(2.0)
        border.backgroundColor = UIColor.darkGray
        border.frame = CGRect(x: 0, y: textfiled.frame.size.height , width:  textfiled.frame.width , height: 2)
        
      //  NSLayoutConstraint.activate([border.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),border.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),self.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),border.heightAnchor.constraint(equalToConstant: 1)])
        
        
        return border
        
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func show(with transition : Transition, duration : CFTimeInterval = 0.5, completion : (()->())?) {
        
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = transition.type
        animation.duration = duration
       
        self.layer.add(animation, forKey: kCATransitionPush)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion?()
        }
    }
    
    // MARK:- Dismiss view
    
    func dismissView(with duration : TimeInterval = 0.3, onCompletion completion : (()->Void)?){
        
        UIView.animate(withDuration: duration, animations: {
            self.frame.origin.y += self.frame.height
        }) { (_) in
            self.removeFromSuperview()
            completion?()
        }
    }
    
    
    func dismissKeyBoardonTap(){
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.endEditingForce)))
        
    }
    
   @IBAction func endEditingForce(){
        
        self.endEditing(true)
        
    }
    
    
    // Hide and show in Dispatch Main thread
    
    func isHideInMainThread(_ isHide : Bool){
        
        DispatchQueue.main.async {
           
            if isHide {
                UIView.animate(withDuration: 0.1, animations: {
                     self.isHidden = isHide
                })
            } else {
                 self.isHidden = isHide
            }
            
        }
        
    }
    
    // Set Tint color
    
    @IBInspectable
    var tintColorId : Int {
        
        get {
           return self.tintColorId
        }
        set(newValue){
            self.tintColor = {
                
                if let color = Color.valueFor(id: newValue){
                    return color
                } else {
                    return tintColor
                }
                
            }()
        } 
    }
    
    
   //Set background color
    
    @IBInspectable
    var backgroundColorId : Int {
        
        get {
            return self.backgroundColorId
        }
        set(newValue){
            self.backgroundColor = {
                
                if let color = Color.valueFor(id: newValue){
                    return color
                } else {
                    return backgroundColor
                }
                
            }()
        }
        
    }
    
    //Setting Corner Radius
    
    @IBInspectable
    var cornerRadius : CGFloat {
        
        get{
          return self.layer.cornerRadius
        }
        
        set(newValue) {
            self.layer.cornerRadius = newValue
        }
        
    }
    
    
    //MARK:- Setting bottom Line
    
    @IBInspectable
    var borderLineWidth : CGFloat {
        get {
            return self.layer.borderWidth
        }
        set(newValue) {
            self.layer.borderWidth = newValue
        }
    }
    
    
    //MARK:- Setting border color
    
    @IBInspectable
    var borderColor : UIColor {
        
        get {
            
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set(newValue) {
            self.layer.borderColor = newValue.cgColor
        }
        
    }
    
    
    //MARK:- Shadow Offset
    
    @IBInspectable
    var offsetShadow : CGSize {
        
        get {
           return self.layer.shadowOffset
        }
        set(newValue) {
            self.layer.shadowOffset = newValue
        }
        
        
    }
    
    
    //MARK:- Shadow Opacity
    @IBInspectable
    var opacityShadow : Float {
        
        get{
            return self.layer.shadowOpacity
        }
        set(newValue) {
            self.layer.shadowOpacity = newValue
        }
        
    }
    
    //MARK:- Shadow Color
    @IBInspectable
    var colorShadow : UIColor? {
        
        get{
           return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set(newValue) {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    //MARK:- Shadow Radius
    @IBInspectable
    var radiusShadow : CGFloat {
        get {
             return self.layer.shadowRadius
        }
        set(newValue) {
            
           self.layer.shadowRadius = newValue
        }
    }
    
    //MARK:- Mask To Bounds
    
    @IBInspectable
    var maskToBounds : Bool {
        get {
            return self.layer.masksToBounds
        }
        set(newValue) {
            
            self.layer.masksToBounds = newValue
        }
    }
    
    
    //MARK:- Add Shadow with bezier path
    
    func addShadow(color : UIColor = .gray, opacity : Float = 0.5, offset : CGSize = CGSize(width: 0.5, height: 0.5), radius : CGFloat = 0.5, rasterize : Bool = true, maskToBounds : Bool = false){
        
        layer.masksToBounds = maskToBounds
        self.custom(layer: self.layer, opacity: opacity, offset: offset, color: color, radius: radius)
      //layer.shadowPath = UIBezierPath(rect: self.frame).cgPath
        layer.shouldRasterize = rasterize
        
    }
    
    public func addShadowWithLayer(offset: CGSize = .zero, opacity: Float = 0.65, radius: CGFloat = 20, color: UIColor = .black) {
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.masksToBounds = false
    }
    
    //MARK:- Add shadow by beizer
    
    func addShadowBeizer(){
        
            
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.bounds.width/2).cgPath
            shadowLayer.fillColor = UIColor.blue.cgColor
            shadowLayer.shadowPath = shadowLayer.path
        
          
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 4
            
            self.layer.insertSublayer(shadowLayer, at: 0)
      
        
    }
    
    
    private func custom(layer customLayer : CALayer, opacity : Float, offset : CGSize, color : UIColor, radius : CGFloat){
        
        customLayer.shadowColor = color.cgColor
        customLayer.shadowOpacity = opacity
        customLayer.shadowOffset = offset
        customLayer.shadowRadius = radius
        
        
    }
    func addBackgroundView(in bgView : UIView, gesture : UITapGestureRecognizer?){
        
        let viewSubject = UIView(frame: UIScreen.main.bounds)
        viewSubject.alpha = 0.5
        viewSubject.backgroundColor = .black
        bgView.addSubview(viewSubject)
        UIView.animate(withDuration: 1) {
            viewSubject.alpha = 0.4
        }
        viewBackground = viewSubject
        viewBackground?.addGestureRecognizer(gesture ?? UITapGestureRecognizer())
    }
    
    // Remove background View
    
    func removeBackgroundView() {
        UIView.animate(withDuration: 0.5, animations: {
            viewBackground?.alpha = 0
        }) { (_) in
            viewBackground?.removeFromSuperview()
        }
    }
    
    //MARK:- Make View Round
    
    func makeRoundedCorner(){
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width/2
        
    }
    
    //MARK:- Add Button Animation
    
    func addPressAnimation(with  duration : TimeInterval = 0.2 , transform : CGAffineTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)) {
        
        UIView.animate(withDuration: duration, animations: {
            self.transform = transform
        }) { (bool) in
            UIView.animate(withDuration: duration, animations: {
                self.transform = .identity
            })
        }
    }
    
    // MARK:- Create Half Circle
    
    func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) ->CAShapeLayer{
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: self.bounds.width/2, startAngle: .pi, endAngle: 0 , clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
       // layer.lineWidth = 20
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
      //  layer.lineDashPhase
        layer.position = CGPoint(x: self.bounds.width/2, y: self.bounds.height)
       
        return layer
    }
    
    func showAnimateView(_ view: UIView, isShow: Bool, direction: Transition, duration : Float = 0.8 ) {
        if isShow {
            view.isHidden = false
            self.bringSubview(toFront: view)
            print(direction.type)
            pushTransition(CFTimeInterval(duration), view: view, withDirection: direction)
            
            
        }
        else {
            self.sendSubview(toBack: view)
            view.isHidden = true
            pushTransition(CFTimeInterval(duration), view: view, withDirection: direction)
        }
    }
    
    func pushTransition(_ duration: CFTimeInterval, view: UIView, withDirection direction: Transition) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = direction.type
        animation.duration = duration
        view.layer.add(animation, forKey: kCATransitionMoveIn)
        
    }
    // Shake View
    func shake(){
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func showView(view : UIView, subView : UIView){
        
      /*  let imageview = UIImageView()
        let view = UIView()
        imageView_Help = imageview
        viewMain = view
        self.addSubview(viewMain!)
        viewMain!.addSubview(imageView_Help!)
        
        
        
        viewMain!.translatesAutoresizingMaskIntoConstraints = false
        imageView_Help?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([viewMain!.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),viewMain!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),viewMain!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),viewMain!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)])
        NSLayoutConstraint.activate([imageView_Help!.centerYAnchor.constraint(equalTo: viewMain!.centerYAnchor, constant: 0),imageView_Help!.centerXAnchor.constraint(equalTo: viewMain!.centerXAnchor, constant: 0),imageView_Help!.heightAnchor.constraint(equalTo: viewMain!.heightAnchor, multiplier: 0.5),imageView_Help!.widthAnchor.constraint(equalTo: viewMain!.widthAnchor, multiplier: 0.8)])
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewMain!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewMain!.addSubview(blurEffectView)
        viewMain?.bringSubviewToFront(imageView_Help!)
        
        
        imageView_Help?.contentMode = .scaleAspectFit*/
       // view.addSubview(subView)
        subView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 1) {
            subView.transform = .identity
        }
    }
    func removeView(view: UIView){
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            view.alpha = 1
        }) { (views) in
            view.alpha = 0
            view.transform = .identity
            //view.removeFromSuperview()
        }
    }
    
}






